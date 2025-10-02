import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';
import 'package:kasbli_merchant/core/widgets/app_bar_widget.dart';
import '../../../core/widgets/interactive_map_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/register_cubit.dart';

class FullScreenMap extends StatefulWidget {
  final LatLng initialLocation;
  final double initialZoom;
  final Function(LatLng)? onLocationSelected;

  const FullScreenMap({
    super.key,
    required this.initialLocation,
    this.initialZoom = 11.0,
    this.onLocationSelected,
  });

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  final GlobalKey<InteractiveMapWidgetState> _mapKey =
      GlobalKey<InteractiveMapWidgetState>();
  late GoogleMapController mapController;
  late LatLng selectedLocation;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initialLocation;
    // Auto-get current location on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToCurrentLocation();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onLocationSelected(LatLng location) {
    setState(() {
      selectedLocation = location;
    });
    // Update register cubit
    context.read<RegisterCubit>().lat = location.latitude.toString();
    context.read<RegisterCubit>().long = location.longitude.toString();
    // Notify parent widget
    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(location);
    }
  }

  void _goToCurrentLocation() async {
    final mapWidget = _mapKey.currentState;
    if (mapWidget != null) {
      final location = await mapWidget.getCurrentLocation();
      if (location != null) {
        _onLocationSelected(location);
      }
    }
  }

  void _confirmLocation() {
    if (widget.onLocationSelected != null) {
      widget.onLocationSelected!(selectedLocation);
    }
    Navigator.of(context).pop(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: AppKeys.selectDeliveryLocationTitle.tr(),
        showBackButton: true,
        backButtonBackgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          InteractiveMapWidget(
            key: _mapKey,
            initialLocation: widget.initialLocation,
            initialZoom: widget.initialZoom,
            onLocationSelected: _onLocationSelected,
            onMapCreated: _onMapCreated,
            showMarker: true,
            enableTapToSelect: true,
            enableDragToSelect: true,
            showMyLocation: true,
            enableZoomControls: false,
            markerTitle: 'Delivery Location',
            markerSnippet: 'Drag to move this marker',
          ),
          // Instructions Card
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        AppKeys.mapInstructionSelectDelivery.tr(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Current Location Button
          Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              heroTag: "fullscreen_location",
              mini: true,
              onPressed: _goToCurrentLocation,
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.my_location,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          // Confirm Location Button
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppKeys.confirmDeliveryLocation.tr(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
