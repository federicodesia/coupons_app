import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Discover{

  final String title;
  final int couponsCount;
  final Color backgroundColor;
  final IconData icon;

  Discover(
    this.title,
    this.couponsCount,
    this.backgroundColor,
    this.icon,
  );
}

final List<Discover> discoverList = <Discover> [
  Discover("Most Favourites", 28, Color(0xFFEAA833), Icons.favorite_border_rounded),
  Discover("Newest", 20, Color(0xFF40BAF6), Icons.star_border_rounded),
  Discover("Supermarkets", 56, Color(0xFFA7D5F8), Icons.storefront),
  Discover("Clothes Shops", 36, Color(0xFFFF91AD), Icons.shopping_bag_outlined)
];