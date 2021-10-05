import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:nlpf_web_app/api/models/geo_regions.model.dart';
import 'package:nlpf_web_app/api/repositories/regions.repository.dart';
import 'package:nlpf_web_app/ui/components/button.dart';
import 'package:nlpf_web_app/ui/components/textfield.dart';
import 'package:nlpf_web_app/utils/constants/color.consts.dart';
import 'package:nlpf_web_app/utils/helpers/config.helper.dart';
import 'package:nlpf_web_app/utils/helpers/location.helper.dart';
import 'package:nlpf_web_app/utils/helpers/toast.helper.dart';

import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/geocoding.bloc.dart';
import '../../blocs/geocoding.event.dart';
import '../../blocs/geocoding.state.dart';

class MapScreen extends StatefulWidget {
  @override
  State createState() => MapState();
}

class MapState extends State<MapScreen> {
  GeoRegionModel geoRegions;

  // API
  // ApiGeoRegionsRepository geoRegionsRepository = ApiGeoRegionsRepository()

  // UI
  MapboxMapController mapController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _nameControllerFocus = FocusNode();
  final FocusNode _passwordControllerFocus = FocusNode();
  final _results = [];
  final symbols = [];

  // @override
  // void initState() async {
  //   super.initState();
  //   // this.geoRegions = await .fetchGeoRegions();
  // }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DVF App"),
          actions: [],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // _bui
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.

                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Scaffold(
                  body: FutureBuilder(
                    future: loadConfigFile(),
                    builder: (
                      BuildContext cntx,
                      AsyncSnapshot<Map<String, dynamic>> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        final String token =
                            snapshot.data['mapbox_api_token'] as String;
                        final String style =
                            snapshot.data['mapbox_style_url'] as String;
                        return MapboxMap(
                          accessToken: token,
                          styleString: style,
                          minMaxZoomPreference:
                              const MinMaxZoomPreference(6.0, null),
                          initialCameraPosition: CameraPosition(
                              target: LatLng(46.0, 2.0), zoom: 5),
                          onMapCreated: (MapboxMapController controller) async {
                            mapController = controller;
                            // final result = await acquireCurrentLocation();
                            // await controller.animateCamera(
                            //   CameraUpdate.newLatLng(result),
                            // );

                            // await controller.addCircle(
                            //   CircleOptions(
                            //     circleRadius: 8.0,
                            //     circleColor: '#006992',
                            //     circleOpacity: 0.8,
                            //     geometry: result,
                            //     draggable: false,
                            //   ),
                            // );
                          },
                          onMapClick:
                              (Point<double> point, LatLng coordinates) {
                            BlocProvider.of<GeocodingBloc>(context)
                              ..add(
                                RequestGeocodingEvent(
                                  latitude: coordinates.latitude,
                                  longitude: coordinates.longitude,
                                ),
                              );
                            _setupBottomModalSheet(cntx);
                          },
                          onMapLongClick:
                              (Point<double> point, LatLng coordinates) async {
                            final ByteData imageBytes =
                                await rootBundle.load('assets/place_24px.png');
                            final Uint8List bytesList =
                                imageBytes.buffer.asUint8List();
                            await mapController.addImage(
                                'place_icon', bytesList);
                            await mapController.addSymbol(
                              SymbolOptions(
                                iconImage: 'place_icon',
                                iconSize: 2.5,
                                geometry: coordinates,
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 16.0,
                              ),
                              Text(
                                  'Error has occurred: ${snapshot.error.toString()}')
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.location_on_sharp),
                    onPressed: () async {
                      final result = await acquireCurrentLocation();
                      await mapController.animateCamera(
                        CameraUpdate.newLatLngZoom(result, 15.0),
                      );

                      await mapController.addCircle(
                        CircleOptions(
                          circleRadius: 8.0,
                          circleColor: '#006992',
                          circleOpacity: 0.8,
                          geometry: result,
                          draggable: false,
                        ),
                      );
                    },
                  ),
                )),

            // MapboxMap(
            //   accessToken: App.ACCESS_TOKEN,
            //   onMapCreated: _onMapCreated,
            //   initialCameraPosition:
            //       const CameraPosition(target: LatLng(46.0, 2.0), zoom: 5),
            //   onStyleLoadedCallback: onStyleLoadedCallback,
            // )),
            Expanded(
              child: Text("COL2"),
            ),
          ],
        ));
  }

  Widget _buildRegionsDropDown() {
    return TextFormFieldWidget(
      hintText: "Username",
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _nameController,
      focusNode: _nameControllerFocus,
      onSubmitField: () {
        // Use this method to change cursor focus
        // First param - Current Controller
        // Second param - The Controller you want to focus on the next button press
        changeFocus(context, _nameControllerFocus, _passwordControllerFocus);
      },
      parametersValidate: "Please enter Username.",
      prefixIcon: Icon(
          Icons.insert_emoticon), // Don't pass image in case of no prefix Icon
    );
  }

  Widget _buildSearchInput() {
    return TextFormFieldWidget(
      hintText: "Username",
      textInputType: TextInputType.text,
      actionKeyboard: TextInputAction.next,
      functionValidate: commonValidation,
      controller: _nameController,
      focusNode: _nameControllerFocus,
      onSubmitField: () {
        // Use this method to change cursor focus
        // First param - Current Controller
        // Second param - The Controller you want to focus on the next button press
        changeFocus(context, _nameControllerFocus, _passwordControllerFocus);
      },
      parametersValidate: "Please enter Username.",
      prefixIcon: Icon(
          Icons.insert_emoticon), // Don't pass image in case of no prefix Icon
    );
  }

  Widget _buildPassword() {
    return TextFormFieldWidget(
      hintText: "Password",
      obscureText: true,
      textInputType: TextInputType.visiblePassword,
      actionKeyboard: TextInputAction.done,
      functionValidate: commonValidation,
      controller: _passwordController,
      focusNode: _passwordControllerFocus,
      onSubmitField: () {},
      parametersValidate: "Please enter password.",
      prefixIcon: Icon(Icons.keyboard_hide),
    );
  }

  Widget _buildNextButton() {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Next",
        leadingIcon: Icon(Icons.send),
        height: 50.0,
        borderRadius: 5,
        color: COLOR_PRIMARY,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: COLOR_PRIMARY,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          var validate = _formKey.currentState.validate();
          if (validate) {
            hideKeyboard();
            _formKey.currentState.save();
            ToastsUtils.displayToast("Fields validated...");
            // Perform operation
          }
        });
  }

  Widget _buildSnackbarButton(BuildContext context) {
    return raisedButton(
        textColor: Colors.white,
        minWidth: 300,
        text: "Show Snackbar",
        height: 50.0,
        borderRadius: 5,
        color: COLOR_PRIMARY,
        borderSideColor: Colors.white,
        splashColor: Colors.blue[200],
        style: TextStyle(
          color: COLOR_PRIMARY,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        onClick: () {
          hideKeyboard();
          Scaffold.of(context)
              .showSnackBar(ToastsUtils.displaySnackBar("This is Snackbar"));
        });
  }

  void onStyleLoadedCallback() {}

  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _setupBottomModalSheet(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocBuilder<GeocodingBloc, GeocodingState>(
          builder: (BuildContext cntx, GeocodingState state) {
            if (state is LoadingGeocodingState) {
              return Container(
                height: 158.0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text('Loading results')
                    ],
                  ),
                ),
              );
            } else if (state is SuccessfulGeocodingState) {
              final latitudeString =
                  state.result.coordinates.latitude.toStringAsPrecision(5);
              final longitudeString =
                  state.result.coordinates.longitude.toStringAsPrecision(5);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: [
                    ListTile(
                      title: Text('Coordinates (latitude/longitude)'),
                      subtitle: Text(
                        '$latitudeString/$longitudeString',
                      ),
                    ),
                    ListTile(
                      title: Text('Place name'),
                      subtitle: Text(state.result.placeName),
                    ),
                  ],
                ),
              );
            } else if (state is FailedGeocodingState) {
              return ListTile(
                title: Text('Error'),
                subtitle: Text(state.error),
              );
            } else {
              return ListTile(
                title: Text('Error'),
                subtitle: Text('Unknown error'),
              );
            }
          },
        );
      },
    );
  }
}