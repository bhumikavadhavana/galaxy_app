import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final PageController _pageController = PageController();
  double _Progress = 0.33;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 500,
                width: 500,
                child: PageView(
                  controller: _pageController,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        "assets/images/s4.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        "assets/images/s5.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                        "assets/images/s3.png",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            "Explore the \n Universe!",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 45, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Learn more about the \n universe where we all live..",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.blue,
                    value: _Progress == 0.99 ? 1 : _Progress,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        _Progress += 0.33;
                      },
                    );
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                          _pageController.page!.toInt() + 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    }
                    if (_pageController.page!.toInt() == 2) {
                      Navigator.of(context).pushReplacementNamed('HomePage');
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
