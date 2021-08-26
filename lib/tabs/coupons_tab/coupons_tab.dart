import 'dart:ui';
import 'package:coupons_app/constants.dart';
import 'package:coupons_app/models/discover.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CouponsTab extends StatefulWidget{

  @override
  _CouponsTabState createState() => _CouponsTabState();
}

class _CouponsTabState extends State<CouponsTab>{

  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(cPadding),
                child: Row(
                  children: [
                    Text(
                      "Discover",
                      style: cHeaderTextStyle
                    ),
                    Spacer(),

                    Text(
                      "view all",
                      style: cTextStyle,
                    ),

                    Icon(
                      Icons.navigate_next,
                      size: 16.0,
                      color: cLightColor
                    )
                  ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: cPadding),
                child: SizedBox(
                  height: 164.0,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: cPadding),
                    scrollDirection: Axis.horizontal,
                    itemCount: discoverList.length,
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(width: 12.0,);
                    },
                    itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        width: 148.0,
                        child: DiscoverCard(discoverList[index])
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DiscoverCard extends StatelessWidget{
  final Discover discover;
  DiscoverCard(this.discover);

  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.zero,
      color: discover.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: cCardBorderRadius
      ),
      child: Stack(
        children: [
          DiscoverCardShadow(
            xTranslate: 0,
            yTranslate: -86,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.04)
              ]
            )
          ),
          DiscoverCardShadow(
            xTranslate: 48,
            yTranslate: 48,
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.white.withOpacity(0.08),
                Colors.white.withOpacity(0.02)
              ]
            )
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  discover.title,
                  style: cTextStyle.copyWith(
                    fontSize: 16.0,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 4.0,),

                Text(
                  discover.couponsCount.toString() + " coupons",
                  style: cTextStyle.copyWith(
                    color: Colors.white.withOpacity(0.9)
                  ),
                ),
                Spacer(),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    discover.icon,
                    size: 32.0,
                    color: Colors.white.withOpacity(0.4),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DiscoverCardShadow extends StatelessWidget{
  final double xTranslate;
  final double yTranslate;
  final Gradient gradient;
  DiscoverCardShadow({required this.xTranslate, required this.yTranslate, required this.gradient});

  Widget build(BuildContext context){
    return Center(
      child: Transform.translate(
        offset: Offset(xTranslate, yTranslate),
        child: Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 116,
            height: 116,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: gradient
            )
          ),
        ),
      ),
    );
  }
}