import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class HojaMap {
//Mapa que se utiliza en la vista de partido, al ingresar en hoja avanzada

  Widget map(BuildContext context, double latitud, double longitud) {
    print("LATITUD $latitud LONGITUD $longitud");
    late List<Marker> marcadores = [
      Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(latitud, longitud),
        child: const Icon(
          Icons.local_activity,
          color: Colors.purple,
        ),
      )
    ];
    return Container(
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(latitud, longitud),
          initialZoom: 13.2,
        ),
        children: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () =>
                    launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ],
          ),
          TileLayer(
            urlTemplate:
                'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: marcadores,
          ),
        ],
      ),
    );
  }
}
