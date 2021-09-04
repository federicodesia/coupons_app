import 'package:coupons_app/components/circular_border_hero.dart';
import 'package:flutter/material.dart';
import 'package:coupons_app/constants.dart';
import 'package:coupons_app/models/coupon.dart';

class CouponCard extends StatelessWidget{
  final Coupon coupon;
  final BuildContext context;
  final int index;
  final Function() onTap;

  CouponCard({required this.coupon, required this.context, required this.index, required this.onTap});

  Widget build(BuildContext context){

    final textColor = ThemeData.estimateBrightnessForColor(coupon.backgroundColor)
                        == Brightness.dark? cDarkCardTextColor : cLightCardTextColor;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 16.0,
              color: Colors.black12,
            )
          ],
          borderRadius: cCardBorderRadius
        ),

        child: Stack(
          children: [
            CircularBorderHero(
              radius: 18.0,
              tag: "card" + index.toString(),
              child: Card(
                margin: EdgeInsets.zero,
                color: coupon.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: cCardBorderRadius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        coupon.getCompanyImage,
                        height: 24.0,
                        width: 48.0,
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(height: 4.0),

                      Text(
                        coupon.title,
                        style: cTextStyle.copyWith(
                          color: textColor.withOpacity(0.72),
                        ),
                      ),
                      SizedBox(height: 4.0),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coupon.discountType == DiscountType.Percentage
                              ? coupon.discount.toStringAsFixed(0)
                              : coupon.discount.toStringAsFixed(2),
                            style: cTextStyle.copyWith(
                              height: 1,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                              fontSize: 32.0
                            ),
                          ),
                          SizedBox(width: 2.0,),

                          Visibility(
                            visible: coupon.discountType == DiscountType.Percentage,
                            child: Text(
                              "%",
                              style: cTextStyle.copyWith(
                                height: 1.1,
                                color: textColor.withOpacity(0.64),
                                fontSize: 14.0
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.zero,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: cCardBorderRadius
              ),
              elevation: 0,
              child: Stack(
                children: [
                  Positioned(
                    right: -56.0,
                    top: -12.0,
                    child: Hero(
                      tag: "couponImage" + index.toString(),
                      child: Image.asset(
                        coupon.getImage,
                        width: 256.0,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}