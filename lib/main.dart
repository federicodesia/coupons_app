import 'package:coupons_app/constants.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context){
    return Container(
      // Linear gradient background
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF1F3FA),
            Color(0xFFE7E8F8)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: DefaultTabController(
        length: 2,
        initialIndex: 1,
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: AppBarIconButton(
              icon: Icons.chevron_left_rounded,
              onPressed: () {},
            ),
            actions: [
              AppBarIconButton(
                icon:  Icons.search_rounded,
                onPressed: () {},
              ),
              AppBarIconButton(
                icon: Icons.notes_rounded,
                onPressed: () {},
              ),
              SizedBox(width: 12.0),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight + 8.0),
              child: Theme(
                  data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent
                ),
                child: TabBar(
                  indicator: BoxDecoration(),
                  labelPadding: kTabLabelPadding.copyWith(bottom: 8.0),
                  labelStyle: cTabTextStyle,
                  labelColor: cTextColor,
                  unselectedLabelColor: cLightColor,
                  tabs: [
                    Tab(text: "Loyality Cards"),

                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Coupons"
                          ),
                          SizedBox(width: 4.0,),

                          Container(
                            height: 22.0,
                            width: 22.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFECBC61),
                              borderRadius: BorderRadius.circular(16.0)
                            ),
                            child: Center(
                              child: Text(
                                "2",
                                style: cTabTextStyle.copyWith(
                                  fontSize: 13.0,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]
                ),
              ),
            ),
          ),
          body: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              // Loyality Cards Tab
              Container(),

              // Coupons Tab
              Container()
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarIconButton extends StatelessWidget{
  final IconData icon;
  final Function() onPressed;
  AppBarIconButton({required this.icon, required this.onPressed});

  Widget build(BuildContext context){
    return IconButton(
      icon: Icon(
        icon,
        color: cLightColor,
        size: 28.0,
      ),
      onPressed: onPressed,
    );
  }
}