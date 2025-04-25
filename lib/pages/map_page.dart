import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Instancia del mapa
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    // Traemos la informacion como argumentos desde la pantalla de home
    final route = ModalRoute.of(context);
    final args = route?.settings.arguments;

    if (args is! ScanModel) {
      return Scaffold(body: Center(child: Text('No scan data found')));
    }
    final ScanModel scan = args;

    // Agregamos la longitud y la lactitud desde la base de datos
    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17.5,
    );

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(
      Marker(markerId: MarkerId('geo-location'), position: scan.getLatLng()),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on_outlined),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              await controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(target: scan.getLatLng(), zoom: 17.5),
                ),
              );
            },
          ),
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
