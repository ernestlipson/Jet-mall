import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:cdc_mall/features/home/data/models/home_models.dart';

class PromoBannerService {
  static Future<List<PromoBanner>> loadPromoBanners() async {
    try {
      final String jsonString = await rootBundle
          .loadString('assets/json/promo_banner/promo_banner_data.json');

      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final List<dynamic> promoBannersJson = jsonData['promo_banners'];

      final List<PromoBanner> promoBanners = promoBannersJson.map((bannerJson) {
        return PromoBanner(
          title: bannerJson['title'],
          description: bannerJson['description'],
          imageUrl: bannerJson['imageUrl'],
          buttonText: bannerJson['buttonText'],
        );
      }).toList();

      return promoBanners;
    } catch (e) {
      print('Error loading promo banners: $e');
      return [];
    }
  }
}
