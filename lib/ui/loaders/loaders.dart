import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

abstract class AppLoaders {
  static Shimmer appTitle = Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    child: Text(
      S.current.title,
      style: const TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static CarouselSlider carouselSlider = CarouselSlider.builder(
    itemCount: 10,
    itemBuilder: (context, index, realIndex) => Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.grey.shade300,
      child: Stack(
        children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            width: double.maxFinite,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withOpacity(0.5),
            ),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppLoaders.appTitle,
                Container(
                  height: 12,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Container(
                  height: 12,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    options: CarouselOptions(
      viewportFraction: 0.70,
      height: 220,
      autoPlay: true,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(
        seconds: 10,
      ),
    ),
  );

  static Shimmer nullContainer = Shimmer.fromColors(
    baseColor: Colors.white,
    highlightColor: Colors.grey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(32),
          width: double.maxFinite,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
        ),
      ],
    ),
  );
}
