import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/galaxy_model.dart';
import '../../provider/themeprovider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  List bookMark = [];
  List Bookmark1 = [];
  String SelectedOption = "Option 1";
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
      lowerBound: 0,
      upperBound: 1,
    );
    animationController.repeat();
    animationController.addListener(() {
      setState(() {});
    });
    sizeAnimation = TweenSequence(<TweenSequenceItem>[
      TweenSequenceItem(tween: Tween<double>(begin: 20, end: 50), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 50, end: 80), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 80, end: 120), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 120, end: 400), weight: 1),
    ]).animate(animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Planet data = ModalRoute.of(context)!.settings.arguments as Planet;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Bookmark1.add(data.name);
              bookMark.add(data.name);
            },
            icon: Icon(
              Icons.favorite_outline,
            ),
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Option 1",
                child: Row(
                  children: [
                    const Icon(Icons.bookmark_add_outlined,
                        color: Colors.black),
                    const Text("All BookMark"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Option 2",
                child: Row(
                  children: [
                    const Icon(
                      Icons.light_mode_outlined,
                      color: Colors.black,
                    ),
                    const Text("Theme"),
                  ],
                ),
              ),
            ],
            onSelected: (selectedOption) {
              setState(() {
                SelectedOption = selectedOption;
              });
              if (selectedOption == "Option 1") {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                        ),
                                      ),
                                      Text(
                                        "Dismiss",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: ListView.builder(
                                itemCount: bookMark.length,
                                itemBuilder: (context, i) => ListTile(
                                  title: Text("${data.name}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bookMark.remove(data.name);
                                        Bookmark1.remove(data.name);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (selectedOption == "Option 2") {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changeTheme();
                      },
                      icon: (Provider.of<ThemeProvider>(context)
                              .themeModel
                              .isDark)
                          ? Icon(Icons.nightlight)
                          : Icon(Icons.light_mode),
                    ),
                  );
                });
              }
            },
          ),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "${data.name1}",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              "${data.Details1}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: AnimatedBuilder(
                animation: animationController,
                child: SizedBox(
                  height: sizeAnimation.value,
                  width: sizeAnimation.value,
                  child: Image.asset("${data.image}",),
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage(
                  //       "${data.image}",
                  //     ),
                  //   ),
                  // ),
                ),
                builder: (context, widget) {
                  return Transform.rotate(
                    angle: animationController.value,
                    child: widget,
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Velocity : "),
                        Text("${data.velocity}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Distance :"),
                        Text("${data.distance}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Surface_gravity : "),
                        Text("${data.surface_gravity}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Surface Temo : "),
                        Text("${data.Surface_Temp}"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text("Rotation_period : "),
                        Text("${data.Rotation_Period}"),
                      ],
                    ),
                    Text(
                      "Description",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "${data.description}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
    @override
    void dispose() {
      animationController.dispose();
      super.dispose();
    }
  }
}
