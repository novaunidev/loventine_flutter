import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/models/banner/banner_home.dart';
import '/config.dart';

class BannerHomeProvider with ChangeNotifier {
  BannerHome? _bannerHome;

  BannerHome get bannerHome =>
      _bannerHome ??
      BannerHome(
        id: "",
        afternoon: "",
        evening: '',
        morning: "",
      );

  Future<void> fetchBannerHomes() async {
    const url = '$baseUrl/banner/getBanner';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      _bannerHome = BannerHome.fromJson(json.decode(response.body));
      notifyListeners();
    } else {
      notifyListeners();
      throw Exception('Failed to load images');
    }
    notifyListeners();
  }
}
