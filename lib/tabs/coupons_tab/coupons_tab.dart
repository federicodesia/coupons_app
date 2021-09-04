import 'package:coupons_app/models/coupon.dart';
import 'package:coupons_app/tabs/expanded_coupons/expanded_coupons.dart';
import 'package:flutter/material.dart';
import 'package:coupons_app/constants.dart';
import 'package:coupons_app/models/discover.dart';
import 'components/coupon_card.dart';
import 'components/discover_card.dart';
import 'components/sliver_persistent_header.dart';

class CouponsTab extends StatefulWidget{

  @override
  _CouponsTabState createState() => _CouponsTabState();
}

class _CouponsTabState extends State<CouponsTab>{

  ScrollController scrollController = new ScrollController();
  double scrollOffset = 0.0;
  double discoverOpacity = 1.0;

  void _scrollListener(){
    setState((){
      scrollOffset = scrollController.offset;

      // Lineal funtion: y = (x - 216) / -58
      // Points: (158, 1) (216, 0)
      discoverOpacity = ((scrollController.offset - 216) / -58).clamp(0.0, 1.0);
    });
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return CustomScrollView(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      slivers: [
        // Discover
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

              Opacity(
                opacity: discoverOpacity,
                child: Padding(
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
              ),
            ],
          ),
        ),

        // My Coupons
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegate("My Coupons"),
        ),

        SliverPadding(
          padding: EdgeInsets.all(cPadding).add(EdgeInsets.only(bottom: cPadding + cFloatingActionButtonHeight)),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext buildContext, int index){
                
                final itemHeight = 136.0;
                final heightFactor = 0.8;

                final itemPositionOffset = index  * itemHeight * heightFactor;
                final difference = (scrollOffset - 240) - itemPositionOffset;
                final percent = 1.0 - (difference / (itemHeight * heightFactor));

                final result = percent.clamp(0.0, 1.0);

                return Align(
                  heightFactor: heightFactor,
                  child: SizedBox(
                    height: itemHeight,
                    child: Transform.scale(
                      scale: result,
                      alignment: Alignment(0.0, 0.56),
                      child: Opacity(
                        opacity: result,
                        child: CouponCard(
                          coupon: couponsList[index],
                          context: buildContext,
                          index: index,
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation){
                                  return ExpandedCoupons(index, context, animation);
                                },
                                transitionDuration: Duration(milliseconds: 800),
                                reverseTransitionDuration: Duration(milliseconds: 800)
                              )
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: couponsList.length,
            )
          ),
        ),
      ],
    );
  }
}