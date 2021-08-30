import 'package:flutter/material.dart';
import 'package:coupons_app/constants.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;

  HeaderDelegate(this.title);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(cPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: cHeaderTextStyle.copyWith(height: 1.0),
        ),
      ),
    );
  }

  @override
  double get maxExtent => cPadding * 2 + cHeaderTextStyle.fontSize!.toInt();

  @override
  double get minExtent => cPadding * 2 + cHeaderTextStyle.fontSize!.toInt();

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}