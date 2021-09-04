import 'package:coupons_app/constants.dart';
import 'package:coupons_app/tabs/coupons_tab/coupons_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
              CouponsTab()
            ],
          ),
          bottomNavigationBar: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Bottom Navigation Bar
              SizedBox(
                height: cBottomNavigationBarOptionSize,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, cBottomNavigationBarOptionSize),
                      painter: BottomNavigationBarPainter(cBottomNavigationBarCurve),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BottomNavigationBarButton(
                          icon: Icons.question_answer_rounded,
                          text: "Send Money"
                        ),
                        SizedBox(width: cBottomNavigationBarOptionSize,),
                        BottomNavigationBarButton(
                          icon: Icons.layers_rounded,
                          text: "Services"
                        )
                      ],
                    )
                  ],
                ),
              ),

              // Floating Action Button
              Padding(
                padding: EdgeInsets.only(bottom: cFloatingActionButtonHeight - cBottomNavigationBarOptionSize),
                child: SizedBox(
                  height: cBottomNavigationBarOptionSize,
                  width: cBottomNavigationBarOptionSize,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {},
                      elevation: 1,
                      highlightElevation: 8,
                      backgroundColor: Color(0xFF77C8F7),
                      child: Icon(Icons.crop_free_rounded),
                    ),
                  ),
                ),
              ),
            ],
          )
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

class  BottomNavigationBarButton extends StatelessWidget{
  final IconData icon;
  final String text;
  BottomNavigationBarButton({required this.icon, required this.text});

  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: cBottomNavigationBarOptionColor,
          size: 32.0,
        ),

        Text(
          text,
          style: cTextStyle.copyWith(
            color: cBottomNavigationBarOptionColor,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        )
      ],
    );
  }
}

class BottomNavigationBarPainter extends CustomPainter{
  final double bottom;
  BottomNavigationBarPainter(this.bottom);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.white..style = PaintingStyle.fill;
    Path path = Path();
    
    double space = 48.0;
    double line = space * 2 + 8.0;

    path.lineTo(size.width / 2 - line, 0);
    path.cubicTo(size.width / 2 - space, 0,
                 size.width / 2 - space, bottom,
                 size.width / 2, 24);

    path.cubicTo(size.width / 2 + space, bottom,
                 size.width / 2 + space, 0,
                 size.width / 2 + line, 0);
    path.lineTo(size.width, 0);
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}