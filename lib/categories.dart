import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoryResponse {
  final int count;
  final List<dynamic> results;

  const CategoryResponse({
    required this.count,
    required this.results,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      count: json['count'],
      results: json['results'],
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final int games_count;
  final String image_background;
  final String description;

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.games_count,
    required this.image_background,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      games_count: json['games_count'],
      image_background: json['image_background'],
      description: json['description'],
    );
  }
}

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.title});

  final String title;

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

Future<CategoryResponse> fetchCategory() async {
  final response = await http.get(Uri.parse(
      'https://api.rawg.io/api/genres?key=6c8d73cb5f7247d099a197b7f589d25f&page=1&page_size=10'));

  if (response.statusCode == 200) {
    final category_response =
        CategoryResponse.fromJson(jsonDecode(response.body));
    log(category_response.results.toString());
    return category_response;
  } else {
    throw Exception('Failed to load categories');
  }
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late final Animation<AlignmentGeometry> alignAnimation;

  late Future<CategoryResponse> futureCategories;
  late List<Category> listCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategory();

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    Color.fromARGB(255, 51, 7, 7),
                    Color(0xFF141519),
                  ],
                )),
                child: Text(''),
              ),
              ListTile(
                leading: const Icon(
                  Icons.dashboard,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Dashboard',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                        title: "Games",
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.gamepad,
                  color: Colors.white,
                ),
                title: const Text('Categories',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.bookmark,
                  color: Colors.grey,
                ),
                title: const Text('Favourites',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.history,
                  color: Colors.grey,
                ),
                title: const Text('History',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.grey,
                ),
                title: const Text('Settings',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                onTap: () {},
              ),
            ],
          ),
        )),
        body: AnimationLimiter(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 100.0,
                  child: FadeInAnimation(
                    child: SingleChildScrollView(
                      child: Center(
                        // Center is a layout widget. It takes a single child and positions it
                        // in the middle of the parent.
                        child: Container(
                          // Column is also a layout widget. It takes a list of children and
                          // arranges them vertically. By default, it sizes itself to fit its
                          // children horizontally, and tries to be as tall as its parent.
                          //
                          // Invoke "debug painting" (press "p" in the console, choose the
                          // "Toggle Debug Paint" action from the Flutter Inspector in Android
                          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                          // to see the wireframe for each widget.
                          //
                          // Column has various properties to control how it sizes itself and
                          // how it positions its children. Here we use mainAxisAlignment to
                          // center the children vertically; the main axis here is the vertical
                          // axis because Columns are vertical (the cross axis would be
                          // horizontal).
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xFF131416),
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
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 17, bottom: 10),
                                        child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(children: [
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      print("Category pressed");
                                                    },
                                                    child: Container(
                                                        width: 115,
                                                        height: 115,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(0,
                                                                  255, 172, 64),
                                                              Colors.red,
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ),
                                                        ),
                                                        child: Card(
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Image.network(
                                                            'https://media.rawg.io/media/games/9dd/9ddabb34840ea9227556670606cf8ea3.jpg',
                                                            fit: BoxFit.cover,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                        )).blurred(
                                                        blur: 0.5,
                                                        blurColor: Colors.red,
                                                        colorOpacity: 0.1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        overlay: Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 12),
                                                            child: Text(
                                                              "Indie",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        )),
                                                  )),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 18),
                                                  child: InkWell(
                                                    onTap: () {
                                                      print("Category pressed");
                                                    },
                                                    child: Container(
                                                        width: 115,
                                                        height: 115,
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(0,
                                                                  255, 172, 64),
                                                              Colors.green,
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ),
                                                        ),
                                                        child: Card(
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Image.network(
                                                            'https://media.rawg.io/media/games/0bd/0bd5646a3d8ee0ac3314bced91ea306d.jpg',
                                                            fit: BoxFit.cover,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                        )).blurred(
                                                        blur: 0.5,
                                                        blurColor: Colors.green,
                                                        colorOpacity: 0.2,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        overlay: Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 12),
                                                            child: Text(
                                                              "Strategy",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        )),
                                                  )),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 18),
                                                child: InkWell(
                                                  onTap: () {
                                                    print("Category pressed");
                                                  },
                                                  child: Container(
                                                      width: 115,
                                                      height: 115,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(0,
                                                                255, 172, 64),
                                                            Colors.yellow,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image.network(
                                                          'https://media.rawg.io/media/games/c6b/c6bfece1daf8d06bc0a60632ac78e5bf.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      )).blurred(
                                                      blur: 0.5,
                                                      blurColor: Colors.yellow,
                                                      colorOpacity: 0.1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      overlay: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 12),
                                                          child: Text(
                                                            "RPG",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 18),
                                                child: InkWell(
                                                  onTap: () {
                                                    print("Category pressed");
                                                  },
                                                  child: Container(
                                                      width: 115,
                                                      height: 115,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(0,
                                                                255, 172, 64),
                                                            Colors.blue,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image.network(
                                                          'https://media.rawg.io/media/games/66e/66e90c9d7b9a17335b310ceb294e9365.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      )).blurred(
                                                      blur: 0.5,
                                                      blurColor: Colors.blue,
                                                      colorOpacity: 0.1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      overlay: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 12),
                                                          child: Text(
                                                            "Casual",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 18),
                                                child: InkWell(
                                                  onTap: () {
                                                    print("Category pressed");
                                                  },
                                                  child: Container(
                                                      width: 115,
                                                      height: 115,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(0,
                                                                255, 172, 64),
                                                            Colors.orange,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image.network(
                                                          'https://media.rawg.io/media/games/e0f/e0f05a97ff926acf4c8f43e0849b6832.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      )).blurred(
                                                      blur: 0.5,
                                                      blurColor: Colors.orange,
                                                      colorOpacity: 0.1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      overlay: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 12),
                                                          child: Text(
                                                            "Arcade",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 18),
                                                child: InkWell(
                                                  onTap: () {
                                                    print("Category pressed");
                                                  },
                                                  child: Container(
                                                      width: 115,
                                                      height: 115,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color.fromARGB(0,
                                                                255, 172, 64),
                                                            Colors.purple,
                                                          ],
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                        ),
                                                      ),
                                                      child: Card(
                                                        semanticContainer: true,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        child: Image.network(
                                                          'https://media.rawg.io/media/games/283/283e7e600366b0da7021883d27159b27.jpg',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                        ),
                                                      )).blurred(
                                                      blur: 0.5,
                                                      blurColor: Colors.purple,
                                                      colorOpacity: 0.1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25),
                                                      overlay: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 12),
                                                          child: Text(
                                                            "Simulation",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ])),
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
