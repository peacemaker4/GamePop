import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math';
import 'categories.dart';
import 'game.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class GamesResponse {
  final int count;

  final List<dynamic> results;

  const GamesResponse({
    required this.count,
    required this.results,
  });

  factory GamesResponse.fromJson(Map<String, dynamic> json) {
    return GamesResponse(
      count: json['count'],
      results: json['results'],
    );
  }
}

class Game {
  final int id;
  final String slug;
  final String name;
  final String name_original;
  final String description;
  final int metacritic;
  final String released;
  final bool tba;
  final String updated;
  final String background_image;
  final String background_image_additional;
  final String website;
  final double rating;
  final int playtime;

  const Game({
    required this.id,
    required this.slug,
    required this.name,
    required this.name_original,
    required this.description,
    required this.metacritic,
    required this.released,
    required this.tba,
    required this.updated,
    required this.background_image,
    required this.background_image_additional,
    required this.website,
    required this.rating,
    required this.playtime,
  });
}

class GamesPage extends StatefulWidget {
  const GamesPage({super.key, required this.title, required this.category});

  final String title;
  final String category;

  @override
  State<GamesPage> createState() => _GamesPageState();
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

Color getColorFromRating(double rating) {
  if (rating < 2.0) {
    return Colors.red;
  } else if (rating < 4.0) {
    return Colors.orange;
  } else {
    return Colors.green;
  }
}

class _GamesPageState extends State<GamesPage>
    with SingleTickerProviderStateMixin {
  Future<GamesResponse> fetchGames(category, platform_id) async {
    var url =
        'https://api.rawg.io/api/games?key=6c8d73cb5f7247d099a197b7f589d25f';
    url += "&page=1&page_size=10";

    if (category != 'none') {
      url += '&genres=' + category;
    }

    url += "&platforms=" + platform_id.toString();

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final games_response = GamesResponse.fromJson(jsonDecode(response.body));
      return games_response;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  late Animation<double> animation;
  late AnimationController controller;
  late final Animation<AlignmentGeometry> alignAnimation;

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
  void dispose() {
    controller.dispose();
    super.dispose();
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
                  Navigator.pushNamed(context, "/");
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
                  color: Colors.white,
                ),
                title: const Text('Games',
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
        body: FutureBuilder<GamesResponse>(
            future: fetchGames(widget.category, userPlatform.platform_id),
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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => GamePage(
                                          title: snapshot.data!.results[index]
                                              ['name'],
                                          id: snapshot.data!.results[index]
                                              ['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                      width: 150,
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
                                              ['background_image'],
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      )).blurred(
                                      blur: 0.5,
                                      blurColor: rand_color,
                                      colorOpacity: 0.1,
                                      borderRadius: BorderRadius.circular(25),
                                      overlay: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 160),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 20),
                                              Text(
                                                  snapshot.data!.results[index]
                                                      ['name'],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                              SizedBox(height: 10),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemCount: min(
                                                    max(
                                                        1,
                                                        snapshot
                                                            .data!
                                                            .results[index]
                                                                ['genres']
                                                            .length),
                                                    2),
                                                itemBuilder:
                                                    (context, subIndex) {
                                                  return Text(
                                                      snapshot.data!.results[
                                                              index]['genres']
                                                          [subIndex]['name'],
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 13));
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: getColorFromRating(
                                                        snapshot.data!
                                                                .results[index]
                                                            ['rating']),
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                      snapshot
                                                          .data!
                                                          .results[index]
                                                              ['rating']
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: getColorFromRating(
                                                            snapshot.data!
                                                                        .results[
                                                                    index]
                                                                ['rating']),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
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
