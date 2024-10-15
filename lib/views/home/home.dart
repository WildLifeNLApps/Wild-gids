import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wildgids/views/widgets/custom_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isAuthenticated: true,
        selectedIndex: -1,
        body: Column(children: [
          const Text(
            "Home",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
              height: 500,
              child: FlutterMap(
                mapController: MapController(),
                options: const MapOptions(
                  initialCenter: LatLng(51.25851739912562,
                      5.622422796819703), // Center the map over London
                  initialZoom: 11,
                ),
                children: [
                  TileLayer(
                    // Display map tiles from any source
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                    userAgentPackageName: 'com.example.app',
                  ),
                  RichAttributionWidget(
                    // Include a stylish prebuilt attribution widget that meets all requirments
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => launchUrl(Uri.parse(
                            'https://openstreetmap.org/copyright')), // (external)
                      ),
                    ],
                  ),
                ],
              ))
        ]));
  }
}
