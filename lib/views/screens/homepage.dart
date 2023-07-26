import 'dart:convert';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../model/galaxy_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? data;

  List<Planet> planet = [];

  @override
  void initState() {
    super.initState();
    loadJSON();
  }

  Future<void> loadJSON() async {
    data = await rootBundle.loadString("assets/json/galaxy.json");

    setState(() {
      List decodeList = jsonDecode(data!);
      planet = decodeList.map((e) => Planet.fromMap(data: e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://c4.wallpaperflare.com/wallpaper/272/170/432/galaxy-planet-planets-space-wallpaper-preview.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 50,
            ),
            (planet.isNotEmpty)
                ? CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 500,
                      viewportFraction: 0.8,
                      autoPlayAnimationDuration: Duration(seconds: 3),
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true,
                    ),
                    itemCount: planet.length,
                    itemBuilder: (context, i, _) => GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('detail_page', arguments: planet[i]);
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TweenAnimationBuilder(
                              tween: Tween<double>(
                                begin: 0,
                                end: 2 * pi,
                              ),
                              duration: Duration(milliseconds: 8000),
                              curve: Curves.easeInOut,
                              child: Image.asset(
                                "${planet[i].image}",
                                height: 300,
                              ),
                              builder: (context, val, widget) {
                                return Transform.rotate(
                                  angle: val,
                                  child: widget,
                                );
                              },
                            ),
                            Text(
                              "${planet[i].name}",
                              style: TextStyle(
                                fontSize: 30,
                                color: Color(0xffE8DEF8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),

    );
  }
}
