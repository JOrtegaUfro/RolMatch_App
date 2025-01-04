import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class PartidoMapContainer extends StatefulWidget {
  const PartidoMapContainer(
      {super.key, required this.latitud, required this.longitud});
  final double latitud;
  final double longitud;
  @override
  State<PartidoMapContainer> createState() =>
      _PartidoMapContainerState(latitud, longitud);
}

class _PartidoMapContainerState extends State<PartidoMapContainer> {
  final double latitud;
  final double longitud;
  _PartidoMapContainerState(double this.latitud, double this.longitud);
  late List<Marker> marcadores = [
    Marker(
      width: 40.0,
      height: 40.0,
      point: LatLng(latitud, longitud),
      child: Icon(
        Icons.local_activity,
        color: Colors.purple,
      ),
    )
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
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
          )),
    );
  }
}
