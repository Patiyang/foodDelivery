import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:foodDelivery/models/shops.dart';
import 'package:foodDelivery/provider/shopProvider.dart';
import 'package:foodDelivery/screens/shops/singleShop.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
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
  var shopProvider;
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
    shopProvider = Provider.of<ShopProvider>(context);
    print(shopProvider.shops.length);
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // mapsScreen(),
          placesList(),
        ],
      ),
    );
  }

  Widget placesList() {
    return Container(
      height: 220,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: shopProvider.shops.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SingleShop(
                    shopModel: shopProvider.shops[index],
                  ),
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                // height: 281,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: grey[400],
                      offset: Offset(2, 2),
                      blurRadius: 3,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: ShopsCard(
                  shopModel: shopProvider.shops[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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

class ShopsCard extends StatelessWidget {
  final ShopModel shopModel;

  const ShopsCard({Key key, this.shopModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: orange,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Loading(),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: shopModel.backgroundImage,
                      height: 150,
                      // width: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 170, maxHeight: 30),
                      child: CustomText(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          text: shopModel.name,
                          color: black,
                          letterSpacing: 0,
                          size: 17),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on, size: 17),
                          CustomText(text: shopModel.location, size: 14, letterSpacing: 0, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)), shape: BoxShape.rectangle, color: orange),
                  child: Icon(Icons.directions, color: white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
