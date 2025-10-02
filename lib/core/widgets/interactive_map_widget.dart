import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_helper.dart';

class InteractiveMapWidget extends StatefulWidget {
  final LatLng initialLocation;
  final double initialZoom;
  final Function(LatLng)? onLocationSelected;
  final Function(GoogleMapController)? onMapCreated;
  final bool showMarker;
  final bool enableTapToSelect;
  final bool enableDragToSelect;
  final bool showMyLocation;
  final bool enableZoomControls;
  final String? markerTitle;
  final String? markerSnippet;
  final BitmapDescriptor? markerIcon;

  const InteractiveMapWidget({
    super.key,
    required this.initialLocation,
    this.initialZoom = 11.0,
    this.onLocationSelected,
    this.onMapCreated,
    this.showMarker = true,
    this.enableTapToSelect = true,
    this.enableDragToSelect = true,
    this.showMyLocation = true,
    this.enableZoomControls = false,
    this.markerTitle = 'Selected Location',
    this.markerSnippet = 'Drag to move this marker',
    this.markerIcon,
  });

  @override
  State<InteractiveMapWidget> createState() => InteractiveMapWidgetState();
}

class InteractiveMapWidgetState extends State<InteractiveMapWidget> {
  late GoogleMapController mapController;
  late LatLng selectedLocation;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    if (widget.showMarker) {
      _createMarker();
    }
  }

  @override
  void didUpdateWidget(InteractiveMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialLocation != widget.initialLocation) {
      selectedLocation = widget.initialLocation;
      if (widget.showMarker) {
        _createMarker();
      }
    }
  }

  void _createMarker() {
    if (!widget.showMarker) return;
    
    markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: selectedLocation,
        draggable: widget.enableDragToSelect,
        onDragEnd: widget.enableDragToSelect ? (LatLng newPosition) {
          _updateLocation(newPosition);
        } : null,
        icon: widget.markerIcon ?? 
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: widget.markerTitle ?? 'Selected Location',
          snippet: widget.markerSnippet ?? 'Drag to move this marker',
        ),
      ),
    };
  }

  void _updateLocation(LatLng newLocation) {
    setState(() {
      selectedLocation = newLocation;
      if (widget.showMarker) {
        _createMarker();
      }
    });
    
    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(newLocation);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (widget.onMapCreated != null) {
      widget.onMapCreated!(controller);
    }
  }

  void _onMapTapped(LatLng position) {
    if (widget.enableTapToSelect) {
      _updateLocation(position);
    }
  }

  /// Public method to update the map location programmatically
  void updateLocation(LatLng newLocation, {bool animateCamera = true}) {
    _updateLocation(newLocation);
    if (animateCamera) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: newLocation,
            zoom: widget.initialZoom,
          ),
        ),
      );
    }
  }

  /// Public method to get current location using GPS
  Future<LatLng?> getCurrentLocation() async {
    try {
      final locationHelper = LocationHelper();
      final position = await locationHelper.getCurrentLocation();
      if (position != null) {
        final newLocation = LatLng(position.latitude, position.longitude);
        updateLocation(newLocation, animateCamera: true);
        return newLocation;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error getting location: $e')),
        );
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      onTap: widget.enableTapToSelect ? _onMapTapped : null,
      initialCameraPosition: CameraPosition(
        target: widget.initialLocation,
        zoom: widget.initialZoom,
      ),
      zoomControlsEnabled: widget.enableZoomControls,
      myLocationEnabled: widget.showMyLocation,
      myLocationButtonEnabled: false, // We'll handle this externally
      markers: widget.showMarker ? markers : {},
    );
  }
}
