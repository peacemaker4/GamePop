import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math';

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

Color getRandomColor() {
  final random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin {
  Future<CategoryResponse> fetchCategory() async {
    final response = await http.get(Uri.parse(
        'https://api.rawg.io/api/genres?key=6c8d73cb5f7247d099a197b7f589d25f&page=1&page_size=10'));

    if (response.statusCode == 200) {
      final category_response =
          CategoryResponse.fromJson(jsonDecode(response.body));
      // log(category_response.results.toString());
      return category_response;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  late Animation<double> animation;
  late AnimationController controller;
  late final Animation<AlignmentGeometry> alignAnimation;

  late Future<CategoryResponse> futureCategories;

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
        body: FutureBuilder<CategoryResponse>(
            future: fetchCategory(),
            builder: (context, snapshot) {
              try {
                var rand_color = getRandomColor();
                if (snapshot.hasData) {
                  // If the data is available, display it
                  return ListView.builder(
                    itemCount: snapshot.data!.results.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                              verticalOffset: 100.0,
                              child: FadeInAnimation(
                                  child: ListTile(
                                title: InkWell(
                                  onTap: () {
                                    print("Category pressed");
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                      width: 380,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(0, 255, 172, 64),
                                            rand_color = getRandomColor(),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                      ),
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Image.network(
                                          snapshot.data!.results[index]
                                              ['image_background'],
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      )).blurred(
                                      blur: 0.5,
                                      blurColor: rand_color,
                                      colorOpacity: 0.1,
                                      borderRadius: BorderRadius.circular(25),
                                      overlay: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 12),
                                          child: Text(
                                              snapshot.data!.results[index]
                                                  ['name'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                      )),
                                ),
                              ))));
                    },
                  );
                } else if (snapshot.hasError) {
                  // If there is an error, display it
                  return Center(child: Text('${snapshot.error}'));
                } else {
                  // Otherwise, show a loading indicator
                  return Center(child: CircularProgressIndicator());
                }
              } catch (e) {
                // Catch and handle the error
                print(e); // Print the error to the console
                // Show an alert dialog with the error message
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('An error occurred'),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
