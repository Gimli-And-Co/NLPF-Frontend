import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:nlpf_web_app/ui/app.dart';
import 'package:nlpf_web_app/utils/helpers/config.helper.dart';

class MapScreen extends StatefulWidget {
  @override
  State createState() => MapState();
}

class MapState extends State<MapScreen> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("DVF App"),
          actions: [],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text("COL1"),
            ),
            Expanded(
                flex: 4,
                child: MapboxMap(
                  accessToken: App.ACCESS_TOKEN,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(46.0, 2.0), zoom: 5),
                  onStyleLoadedCallback: onStyleLoadedCallback,
                )),
            Expanded(
              child: Text("COL2"),
            ),
          ],
        ));
  }

  void onStyleLoadedCallback() {}
}
