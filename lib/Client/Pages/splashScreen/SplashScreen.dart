import 'package:camhed/Client/Pages/Pages/loginPage.dart';
import 'package:camhed/Client/Pages/splashScreen/slide_dots.dart';
import 'package:camhed/Client/Pages/splashScreen/slide_item.dart';
import 'package:flutter/material.dart';
import 'SplashData.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // void onAddButtonTapped(int index) {
  //   _pageController.animateToPage(index, curve: null, duration: null);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _firstTime();
  // }

  // _firstTime() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setBool("firstTime", true);
  // }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < slideList.length; i++)
                    if (i == _currentPage) SlideDots(true) else SlideDots(false)
                ],
              ),
            ),
            _currentPage <= 1
                ? Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: height / 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            // onTap: () {
                            //   Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => StartingPage()));
                            // },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffe8364e),
                                  borderRadius:
                                      BorderRadius.circular(height / 95)),
                              height: height / 22,
                              width: width / 4,
                              child: Center(
                                  child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: height / 50),
                              )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentPage += 1;
                                _pageController.animateToPage(
                                  _currentPage,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffe8364e),
                                  borderRadius:
                                      BorderRadius.circular(height / 95)),
                              height: height / 22,
                              width: width / 4,
                              child: Center(
                                  child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: height / 50),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Container(
                      height: height / 8,
                      width: width,
                      color: Colors.white,
                      child: Center(
                        child: SizedBox(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Container(
                              child: Center(
                                  child: Text(
                                "GET STARTED",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: height / 50),
                              )),
                              height: height / 14,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Color(0xffe8364e),
                                  borderRadius:
                                      BorderRadius.circular(height / 95)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
