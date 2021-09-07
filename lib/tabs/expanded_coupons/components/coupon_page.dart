import 'package:coupons_app/constants.dart';
import 'package:coupons_app/models/coupon.dart';
import 'package:flutter/material.dart';
import 'scroll_effect.dart';

class CouponPage extends StatelessWidget{

  CouponPage({required this.coupon, required this.buildContext, required this.index, required this.currentPage, required this.transitionAnimation});

  final Coupon coupon;
  final BuildContext buildContext;
  final int index;
  final double currentPage;
  final Animation<double> transitionAnimation;

  Widget build(BuildContext context){

    final textColor = ThemeData.estimateBrightnessForColor(coupon.backgroundColor)
                      == Brightness.dark ? cDarkCardTextColor : cLightCardTextColor;

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: FadeTransition(
        opacity: transitionAnimation,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * cCouponTopSizeFactor,
              padding: EdgeInsets.all(cCouponPadding).add(EdgeInsets.only(top: MediaQuery.of(buildContext).padding.top)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // Title
                  Column(
                    children: [
                      ScrollEffect(
                        index: index,
                        currentPage: currentPage,
                        translationFactor: 0,
                        opacityFactor: 0.12,
                        child: Image.asset(
                          coupon.getCompanyImage,
                          height: 38.0,
                          width: 48.0,
                        )
                      ),
                      SizedBox(height: 12.0,),
                      ScrollEffect(
                        index: index,
                        currentPage: currentPage,
                        translationFactor: 65,
                        opacityFactor: 0.18,
                        child: Text(
                          coupon.title,
                          style: cTextStyle.copyWith(
                            fontSize: 14.5
                          ),
                        )
                      ),
                    ],
                  ),

                  // Discount
                  ScrollEffect(
                    index: index,
                    currentPage: currentPage,
                    translationFactor: 250,
                    opacityFactor: 0.15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coupon.discountType == DiscountType.Percentage
                            ? coupon.discount.toStringAsFixed(0)
                            : coupon.discount.toStringAsFixed(2),
                          style: cTextStyle.copyWith(
                            height: 1,
                            fontWeight: FontWeight.w500,
                            color: cLightCardTextColor,
                            fontSize: 56.0
                          ),
                        ),
                        SizedBox(width: 2.0,),

                        Visibility(
                          visible: coupon.discountType == DiscountType.Percentage,
                          child: Text(
                            "%",
                            style: cTextStyle.copyWith(
                              height: 1.1,
                              color: cLightCardTextColor.withOpacity(0.64),
                              fontSize: 24.0
                            ),
                          ),
                        ),
                      ],
                    )
                  ),

                  // Expiration
                  ScrollEffect(
                    index: index,
                    currentPage: currentPage,
                    translationFactor: 0,
                    opacityFactor: 0.12,
                    child: Text(
                      "Exp " + coupon.expirationDate,
                      style: cTextStyle.copyWith(
                        color: cLightColor.withOpacity(0.48),
                        fontSize: 13.0
                      )
                    )
                  ),
                ],
              ),
            ),

            // Description
            ClipRRect(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * (1.0 - cCouponTopSizeFactor),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, -1.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: transitionAnimation,
                      curve: Curves.ease
                    )
                  ),
                  child: ScrollEffect(
                    index: index,
                    currentPage: currentPage,
                    translationFactor: 0,
                    opacityFactor: 0.12,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: cCouponPadding,
                        vertical: cCouponPadding + 8.0
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon.descriptionTitle,
                            style: cTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.5,
                              color: textColor
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            coupon.description,
                            style: cTextStyle.copyWith(
                              fontSize: 13.5,
                              color: textColor
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}