import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

import '../Constants.dart';
import '../styling.dart';
import '../widgets/customText.dart';
import '../widgets/loading.dart';

class Location extends StatefulWidget {
  final double latitude;
  final double longitude;

  const Location({Key key, this.latitude, this.longitude}) : super(key: key);
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
  GeocodingPlatform geocodingPlatform;
  CameraPosition cameraPosition;
  LatLng currentPostion;
  LatLng lastPosition;
  double cameraZoom = 7;
  bool loading = false;
  // final ApiManagement _apiManagement = new ApiManagement();
  List<Marker> restaurantMarkers = [];
  Map<PolylineId, Polyline> polylines = {};
  Completer<GoogleMapController> mapsController = Completer();
  GoogleMapController mapcontroller;
  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  double _originLatitude = -2.4219983, _originLongitude = 38.084;
  @override
  void initState() {
    _getUserLocation();
    super.initState();
  }

  Future<CameraPosition> _getUserLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPostion = LatLng(-2.4213, 38.084);
    // currentPostion = LatLng(position.latitude, position.longitude);
    if (widget.latitude != null && widget.longitude != null) {
      _getPolyline(widget.latitude, widget.longitude);
    }
    cameraPosition = CameraPosition(target: currentPostion, zoom: cameraZoom);
    return cameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          mapsScreen(),
          // placesList(),
        ],
      ),
    );
  }

  Widget placesList() {}
  Widget mapsScreen() {
    return FutureBuilder(
      future: _getUserLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        cameraPosition = snapshot.data;
        if (snapshot.hasData) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              compassEnabled: true,
              onMapCreated: _onMapCreated,
              markers: Set.from(restaurantMarkers),
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onCameraMove: onCameraMove,
              polylines: Set<Polyline>.of(polylines.values),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: CustomText(
              text: 'Failed to load location data',
              textAlign: TextAlign.center,
            ),
          );
        }
        return Loading();
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapcontroller = controller;
  }

  onCameraMove(CameraPosition position) {
    setState(() {
      lastPosition = position.target;
    });
  }

  _addPolyLine(String polyId) {
    PolylineId id = PolylineId(polyId);
    Polyline polyline = Polyline(
        polylineId: id, color: orange, points: polylineCoordinates, width: 3, endCap: Cap.roundCap, jointType: JointType.round);
    polylines[id] = polyline;
    setState(() {});
  }

  void _getPolyline(double latitude, double longitude) async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.MAP_API_KEY,
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(latitude, longitude),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    var id = Uuid();
    String polyId = id.v1();
    _addPolyLine(polyId);
  }
}
