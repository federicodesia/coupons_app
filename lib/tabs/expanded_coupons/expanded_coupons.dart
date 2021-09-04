import 'package:coupons_app/components/circular_border_hero.dart';
import 'package:coupons_app/constants.dart';
import 'package:coupons_app/helpers/size_helper.dart';
import 'package:coupons_app/models/coupon.dart';
import 'package:coupons_app/tabs/expanded_coupons/components/coupon_page.dart';
import 'package:flutter/material.dart';

class ExpandedCoupons extends StatefulWidget{

  ExpandedCoupons(
    this.initialCoupon,
    this.buildContext,
    this.transitionAnimation,
  );

  final int initialCoupon;
  final BuildContext buildContext;
  final Animation<double> transitionAnimation;

  @override
  _ExpandedCouponsState createState() => _ExpandedCouponsState();
}

const double imageFactor = 1.25;

class _ExpandedCouponsState extends State<ExpandedCoupons>{

  late PageController pageController;
  late double currentPage;

  late ScrollController couponsController;
  late ScrollController imagesController;

  late List<bool> heroAnimations;
  late Animatable<Color?> backgroundColor;

  bool transitionCompleted = false;
  bool visibleAppBar = false;

  void onScroll(){
    setState(() {
      currentPage = pageController.page!;

      if(couponsController.hasClients) couponsController.jumpTo(currentPage * MediaQuery.of(context).size.width);
      if(imagesController.hasClients) imagesController.jumpTo(currentPage * MediaQuery.of(context).size.width * imageFactor);
    });
  }

  void onBack(){
    setState(() => visibleAppBar = false);
  }

  void onTransitionCompleted(){
    if(widget.transitionAnimation.isCompleted){
      setState((){
        transitionCompleted = true;
        visibleAppBar = true;
      });
    }
  }

  @override
  void initState(){

    // PageController
    pageController = PageController(
      initialPage: widget.initialCoupon
    );
    currentPage = widget.initialCoupon.toDouble();
    pageController.addListener(onScroll);

    // Coupons SrollController
    couponsController = ScrollController(
      initialScrollOffset: currentPage * MediaQuery.of(widget.buildContext).size.width
    );

    // Images SrollController
    imagesController = ScrollController(
      initialScrollOffset: currentPage * (MediaQuery.of(widget.buildContext).size.width * imageFactor)
    );

    // HeroAnimations
    heroAnimations = List.generate(couponsList.length, (index) => false);
    heroAnimations[widget.initialCoupon] = true;

    // BackgroundColor
    backgroundColor = TweenSequence<Color?>(
      List<TweenSequenceItem<Color?>>.generate(couponsList.length - 1, (index) => new TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: couponsList[index].backgroundColor,
          end: couponsList[index + 1].backgroundColor
        )
      ))
    );

    // Transition completed
    widget.transitionAnimation.addListener(onTransitionCompleted);

    super.initState();
  }

  @override
  void dispose(){
    pageController.removeListener(onScroll);
    widget.transitionAnimation.removeListener(onTransitionCompleted);

    couponsController.dispose();
    imagesController.dispose();
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeHelper().init(context);
    final int _currentPage = currentPage.round();

    return WillPopScope(
      onWillPop: (){
        onBack();
        return Future.value(transitionCompleted);
      },
      child: IgnorePointer(
        ignoring: !transitionCompleted,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarOpacity: visibleAppBar ? 1.0 : 0.0,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left_rounded,
                color: cLightColor,
                size: 28.0,
              ),
              onPressed: () {
                if(transitionCompleted){
                  onBack();
                  Navigator.pop(context);
                }
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.reply_rounded,
                  color: cLightColor,
                  size: 28.0,
                ),
                onPressed: () {},
              ),
              SizedBox(width: 12.0),
            ],
          ),
          body: Stack(
            children: [

              // Animated Transition.
              HeroMode(
                enabled: heroAnimations[_currentPage],
                child: CircularBorderHero(
                  radius: 0.0,
                  tag: "card" + _currentPage.toString(),
                  child: Material(
                    
                    // Animated Background Color.
                    child: AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        final color = pageController.hasClients 
                          ? pageController.page! / (couponsList.length - 1)
                          : widget.initialCoupon / (couponsList.length - 1);
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: backgroundColor.evaluate(AlwaysStoppedAnimation(color)),
                          ),
                          child: child,
                        );
                      },
                      child: Stack(
                        children: [

                          // Top white space
                          Container(
                            height: MediaQuery.of(context).size.height * cCouponTopSizeFactor,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(cCouponPadding),
                                bottomRight: Radius.circular(cCouponPadding)
                              ),
                              color: Colors.white
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: cCouponPadding,
                                bottom: 20.0
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Icon(
                                  Icons.info_rounded,
                                  size: 28.0,
                                  color: cLightColor.withOpacity(0.24),
                                )
                              ),
                            ),
                          ),

                          // Coupons
                          SingleChildScrollView(
                            controller: couponsController,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(couponsList.length, (index){
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: CouponPage(
                                    coupon: couponsList[index],
                                    buildContext: widget.buildContext,
                                    index: index,
                                    currentPage: currentPage,
                                    transitionAnimation: widget.transitionAnimation,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                ),
              ),

              // Coupon images
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: getHeight(400.0),
                  child: SingleChildScrollView(
                    controller: imagesController,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(couponsList.length, (index){
                        final double rotation = (currentPage - index).clamp(-1.0, 1.0);

                        return Transform.translate(
                          offset: Offset(getWidth(64.0), getWidth(156.0)),
                          child: Transform.rotate(
                            angle: couponsList[index].animationType == AnimationType.Rotation ? rotation * 3 : 0,
                            child: HeroMode(
                              enabled: heroAnimations[index],
                              child: Hero(
                                tag: "couponImage" + index.toString(),
                                child: Image.asset(
                                  couponsList[index].getImage,
                                  width: MediaQuery.of(context).size.width * 1.25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                    ),
                  ),
                ),
              ),

              // Full screen PageView
              PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemCount: couponsList.length,
                onPageChanged: (index){
                  setState(() {
                    heroAnimations.fillRange(0, heroAnimations.length, false);
                    heroAnimations[index] = true;
                  });
                },
                itemBuilder: (context, index){
                  return Container();
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}