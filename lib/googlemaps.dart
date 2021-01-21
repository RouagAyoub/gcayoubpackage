import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Googlemaps extends StatefulWidget {
  Googlemaps({Key key}) : super(key: key);

  @override
  _GooglemapsState createState() => _GooglemapsState();
}

class _GooglemapsState extends State<Googlemaps> {
  GoogleMapController _controller;
  Position position;
  var placeMark;
  Widget _child;

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    if (permission == PermissionStatus.denied) {
      await PermissionHandler()
          .requestPermissions([PermissionGroup.locationAlways]);
    }

    var geolocator = Geolocator();

    GeolocationStatus geolocationStatus =
        await geolocator.checkGeolocationPermissionStatus();

    switch (geolocationStatus) {
      case GeolocationStatus.denied:
        break;
      case GeolocationStatus.disabled:
        break;
      case GeolocationStatus.restricted:
        break;
      case GeolocationStatus.unknown:
        break;
      case GeolocationStatus.granted:
        _getCurrentLocation();
    }
  }

  Set<Marker> createMarker(double posisionlat, double posotionlon) {
    return <Marker>[
      Marker(
          markerId: MarkerId('home'),
          position: LatLng(posisionlat, posotionlon),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Current Location'))
    ].toSet();
  }

  // ignore: unused_element
  void _getCurrentLocation() async {
    final Geolocator _geolocator = Geolocator();
    Position res = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    try {
      Position res = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        position = res;
        _child = _mapWidget();
      });
      List newPlace = await _geolocator.placemarkFromCoordinates(
          res.latitude, res.longitude);

      // List<Placemark> newPlace =await _geolocator.placemarkFromCoordinates(res.latitude, res.longitude);
      placeMark = newPlace[0];
    } catch (e) {}
  }

  Widget _mapWidget() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: createMarker(position.latitude, position.longitude),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _mapWidget(),
    );
  }
}
