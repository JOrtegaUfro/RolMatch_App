import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rol_match/map/data/services/location_search.dart';
import 'package:rol_match/map/domain/location_coordinate.dart';
import 'package:url_launcher/url_launcher.dart';

//! Contenedor de sección de formulario respectiva a la búsqueda o soleccion deuna ubicación
class FormMapContainer extends StatefulWidget {
  const FormMapContainer({super.key, required this.testing});
  final bool testing;
  @override
  State<FormMapContainer> createState() {
    return _FormMapContainerState(testing);
  }
}

class _FormMapContainerState extends State<FormMapContainer> {
  final TextEditingController _textController = TextEditingController();
  final bool testing;
  double latitud = 0;
  double longitud = 0;
  final List<Marker> marcadores = [];
  LocationCoordinate coordinate = new LocationCoordinate();

  _FormMapContainerState(this.testing);

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWidgets = [Container()];
    if (testing == false) {
      childrenWidgets = [_LocationInput(), _MapView()];
    }
    return Column(children: childrenWidgets);
  }

  //Vista del mapa, obtiene el estado de marcador y se actualiza en base a este
  Widget _MapView() {
    return Container(
      width: 400,
      height: 300,
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(-38.7396500, -72.5984200),
          initialZoom: 13.2,
          onTap: (tapPosition, point) {
            setState(() {
              latitud = point.latitude;
              longitud = point.longitude;
              marcadores.clear();
              coordinate.setCoordinate(longitud, latitud);
              marcadores.add(
                Marker(
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(latitud, longitud),
                  child: Icon(Icons.pin_drop, color: Colors.black),
                ),
              );
            });
          },
        ),
        children: [
          RichAttributionWidget(
            attributions: [],
          ),
          TileLayer(
            urlTemplate:
                "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: marcadores,
          ),
        ],
      ),
    );
  }

  final TextEditingController _textControllerInput = TextEditingController();
  //Si se selecciona dentro del mapa una ubicación se actualiza el estado de los marcadores
  Widget _LocationInput() {
    return Container(
        width: 300,
        child: Column(children: [
          Row(children: [
            Expanded(
              child: TextField(
                controller: _textControllerInput,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.pin_drop,
                    color: Colors.grey,
                  ),
                  border: UnderlineInputBorder(),
                  hintText: 'Buscar ubicación',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                search(_textControllerInput.text);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white)),
              child: const Icon(Icons.search),
            )
          ]),
          SizedBox(
            height: 20,
          )
        ]));
  }

  //Si se utiliza busqueda se actualiza el estado de los marcadores
  Future<void> search(String location) async {
    LocationCoordinate locationCoordinate = LocationCoordinate();
    await locationCoordinate.saveCoordinate(location);
    double newLatitud = await locationCoordinate.getLatitude();
    double newLongitud = await locationCoordinate.getLongitude();

    setState(() {
      latitud = newLatitud;
      longitud = newLongitud;
      print("NEW NEW NEW $newLatitud $newLongitud");
      marcadores.clear();
      marcadores.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: LatLng(latitud, longitud),
          child: Icon(Icons.pin_drop, color: Colors.black),
        ),
      );
    });
  }
}
