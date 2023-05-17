import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/categories.dart';
import 'package:flutter_project_app/games.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'devices.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:provider/provider.dart';
import 'game.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Future<List> fetchData(platform_id) async {
    final response_categories = await http.get(Uri.parse(
        'https://api.rawg.io/api/genres?key=6c8d73cb5f7247d099a197b7f589d25f&page=1&page_size=6'));
    final category_response =
        CategoryResponse.fromJson(jsonDecode(response_categories.body));

    var games_url =
        'https://api.rawg.io/api/games?key=6c8d73cb5f7247d099a197b7f589d25f';
    games_url += "&page=1&page_size=3";

    games_url += "&platforms=" + platform_id.toString();

    final response_games = await http.get(Uri.parse(games_url));
    final games_response =
        GamesResponse.fromJson(jsonDecode(response_games.body));

    return [category_response, games_response];
  }

  late Animation<double> animation;
  late AnimationController controller;
  late final Animation<AlignmentGeometry> alignAnimation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    controller.forward();

    alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPlatform = Provider.of<UserPlatform>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Color.fromARGB(255, 7, 51, 50),
          elevation: 0,
        ),
        backgroundColor: Color(0xFF141519),
        drawer: Drawer(
            child: Container(
          color: Color(0xFF141519),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 7, 51, 50),
                    Color(0xFF141519),
                  ],
                )),
                child: Text(''),
              ),
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                ),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.gamepad,
                  color: Colors.grey,
                ),
                title: const Text('Categories',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pushNamed(context, "/categories");
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.videogame_asset,
                  color: Colors.grey,
                ),
                title: const Text('Games',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pushNamed(context, "/games");
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.bookmark,
              //     color: Colors.grey,
              //   ),
              //   title: const Text('Favourites',
              //       style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600)),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.history,
              //     color: Colors.grey,
              //   ),
              //   title: const Text('History',
              //       style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600)),
              //   onTap: () {},
              // ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.settings,
              //     color: Colors.grey,
              //   ),
              //   title: const Text('Settings',
              //       style: TextStyle(
              //           color: Colors.grey,
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600)),
              //   onTap: () {},
              // ),
            ],
          ),
        )),
        body: FutureBuilder(
          future: fetchData(userPlatform.platform_id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var rand_color = getRandomColor();
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(255, 7, 51, 50),
                          Color(0xFF131416),
                        ],
                            stops: [
                          0,
                          0.25
                        ])),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                AlignTransition(
                                    alignment: alignAnimation,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.end,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 17, bottom: 10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Devices(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  userPlatform.platform
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty.all(
                                                            const Size(
                                                                115, 40)),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Color.fromARGB(174,
                                                                0, 145, 255)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    )))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 18),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          GamesPage(
                                                        title: "Games",
                                                        category: "none",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'Games',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                115, 40)),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Color.fromARGB(175,
                                                                55, 73, 87)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    )))),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 18),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CategoriesPage(
                                                        title: "Categories",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  'More',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                115, 40)),
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                                Color>(
                                                            Color.fromARGB(175,
                                                                55, 73, 87)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    )))),
                                          ),
                                        ]),
                                  ),
                                ),
                                SizedBox(
                                    height: 115,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      scrollDirection: Axis.horizontal,
                                      physics: PageScrollPhysics(),
                                      itemCount:
                                          snapshot.data![0].results.length,
                                      itemBuilder: (context, subIndex) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                                position: subIndex,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                    horizontalOffset: 100.0,
                                                    child: FadeInAnimation(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 18),
                                                            child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  hoverColor:
                                                                      rand_color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                GamesPage(
                                                                          title:
                                                                              snapshot.data![0].results[subIndex]['name'] + " games",
                                                                          category: snapshot
                                                                              .data![0]
                                                                              .results[subIndex]['name']
                                                                              .toString()
                                                                              .toLowerCase(),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                              width:
                                                                                  115,
                                                                              height:
                                                                                  115,
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                gradient: LinearGradient(
                                                                                  colors: [
                                                                                    Color.fromARGB(0, 255, 172, 64),
                                                                                    rand_color = getRandomColor(),
                                                                                  ],
                                                                                  begin: Alignment.topCenter,
                                                                                  end: Alignment.bottomCenter,
                                                                                ),
                                                                              ),
                                                                              child:
                                                                                  Card(
                                                                                semanticContainer: true,
                                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                child: Image.network(
                                                                                  snapshot.data![0].results[subIndex]['image_background'],
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(25),
                                                                                ),
                                                                              ))
                                                                          .blurred(
                                                                              blur: 0.5,
                                                                              blurColor: rand_color,
                                                                              colorOpacity: 0.1,
                                                                              borderRadius: BorderRadius.circular(25),
                                                                              overlay: Align(
                                                                                alignment: Alignment.bottomCenter,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(bottom: 12),
                                                                                  child: Text(
                                                                                    snapshot.data![0].results[subIndex]['name'],
                                                                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                ))))));
                                      },
                                    )),
                                AlignTransition(
                                    alignment: alignAnimation,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 32, bottom: 30),
                                      child: Text(
                                        'Popular',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.end,
                                      ),
                                    )),
                                SizedBox(
                                    width: 378,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: PageScrollPhysics(),
                                      itemCount:
                                          snapshot.data![1].results.length,
                                      itemBuilder: (context, subIndex) {
                                        return AnimationConfiguration
                                            .staggeredList(
                                                position: subIndex,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                    verticalOffset: 100.0,
                                                    child: FadeInAnimation(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 25,
                                                                    right: 12),
                                                            child: Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child: InkWell(
                                                                  hoverColor:
                                                                      rand_color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              25),
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                GamePage(
                                                                          title: snapshot
                                                                              .data![1]
                                                                              .results[subIndex]['name'],
                                                                          id: snapshot
                                                                              .data![1]
                                                                              .results[subIndex]['id'],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                              width:
                                                                                  378,
                                                                              height:
                                                                                  185,
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                gradient: LinearGradient(
                                                                                  colors: [
                                                                                    Color.fromARGB(0, 255, 172, 64),
                                                                                    rand_color = getRandomColor(),
                                                                                  ],
                                                                                  begin: Alignment.topCenter,
                                                                                  end: Alignment.bottomCenter,
                                                                                ),
                                                                              ),
                                                                              child:
                                                                                  Card(
                                                                                semanticContainer: true,
                                                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                                                child: Image.network(
                                                                                  snapshot.data![1].results[subIndex]['background_image'],
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(25),
                                                                                ),
                                                                              ))
                                                                          .blurred(
                                                                              blur: 0.5,
                                                                              blurColor: rand_color,
                                                                              colorOpacity: 0.1,
                                                                              borderRadius: BorderRadius.circular(25),
                                                                              overlay: Align(
                                                                                alignment: Alignment.bottomCenter,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(bottom: 12),
                                                                                  child: Text(
                                                                                    snapshot.data![1].results[subIndex]['name'],
                                                                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                              )),
                                                                ))))));
                                      },
                                    ))
                              ],
                            ))),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error fetching data');
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
