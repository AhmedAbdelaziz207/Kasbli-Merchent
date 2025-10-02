import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';

import '../../../core/widgets/interactive_map_widget.dart';
import '../logic/register_cubit.dart';
import 'full_screen_map.dart';

class LocationsSelector extends StatefulWidget {
  final IconData? currentLocationIcon;
  final Color? currentLocationIconColor;
  final Color? currentLocationButtonColor;
  final RegisterCubit? registerCubit;

  const LocationsSelector({
    super.key,
    this.currentLocationIcon,
    this.currentLocationIconColor,
    this.currentLocationButtonColor,
    this.registerCubit,
  });

  @override
  State<LocationsSelector> createState() => _LocationsSelectorState();
}

class _LocationsSelectorState extends State<LocationsSelector> {
  final GlobalKey<InteractiveMapWidgetState> _mapKey =
      GlobalKey<InteractiveMapWidgetState>();
  late GoogleMapController mapController;
  LatLng currentLocation = const LatLng(30.2707, 31.2707); // Chennai

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onLocationSelected(LatLng location) {
    setState(() {
      currentLocation = location;
    });

    // Update RegisterCubit with new coordinates
    try {
      final cubit = widget.registerCubit ?? context.read<RegisterCubit>();
      cubit.lat = location.latitude.toString();
      cubit.long = location.longitude.toString();
      print(
        'Location updated in cubit: ${location.latitude}, ${location.longitude}',
      );
    } catch (e) {
      print('Error updating location in cubit: $e');
    }
  }

  void _viewFullScreen() async {
    final cubit = widget.registerCubit ?? context.read<RegisterCubit>();
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder:
            (context) => BlocProvider<RegisterCubit>.value(
              value: cubit,
              child: FullScreenMap(
                initialLocation: currentLocation,
                initialZoom: 15.0,
                onLocationSelected: _onLocationSelected,
              ),
            ),
      ),
    );

    if (selectedLocation != null) {
      _onLocationSelected(selectedLocation);
      // Move the main map to the selected location
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: selectedLocation, zoom: 15.0),
        ),
      );
    }
  }

  void _goToCurrentLocation() async {
    final mapWidget = _mapKey.currentState;
    if (mapWidget != null) {
      await mapWidget.getCurrentLocation();
    }
  }

  @override
  void initState() {
    super.initState();
    // Auto-get current location on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: Stack(
        children: [
          InteractiveMapWidget(
            key: _mapKey,
            initialLocation: currentLocation,
            initialZoom: 11.0,
            onLocationSelected: _onLocationSelected,
            onMapCreated: _onMapCreated,
            showMarker: true,
            enableTapToSelect: true,
            enableDragToSelect: true,
            showMyLocation: false,
            enableZoomControls: false,
            markerTitle: AppKeys.storeLocationMarkerTitle.tr(),
            markerSnippet: AppKeys.storeLocationMarkerSnippet.tr(),
          ),
          // Full Screen Button
          Positioned(
            top: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "fullscreen",
              mini: true,
              onPressed: _viewFullScreen,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.fullscreen,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          // Current Location Button
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "location",
              mini: true,
              onPressed: _goToCurrentLocation,
              backgroundColor:
                  widget.currentLocationButtonColor ?? AppColors.primaryColor,
              child: Icon(
                widget.currentLocationIcon ?? Icons.gps_fixed,
                color: widget.currentLocationIconColor ?? Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
