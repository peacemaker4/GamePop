import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/games.dart';
import 'home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math';
import 'categories.dart';

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
  final List<dynamic> genres;

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
    required this.genres,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      name_original: json['name_original'],
      description: json['description'],
      metacritic: json['metacritic'],
      released: json['released'],
      tba: json['tba'],
      updated: json['updated'],
      background_image: json['background_image'],
      background_image_additional: json['background_image_additional'],
      website: json['website'],
      rating: json['rating'],
      playtime: json['playtime'],
      genres: json['genres'],
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    required this.title,
    required this.id,
  });

  final String title;
  final int id;

  @override
  State<GamePage> createState() => _GamePageState();
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

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableText({Key? key, required this.text, required this.maxLines})
      : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: Text(widget.text,
                maxLines: _isExpanded ? 10 : widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500))),
        TextButton(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          child: Text(_isExpanded ? 'Show less' : 'Show more'),
        ),
      ],
    );
  }
}

class _GamePageState extends State<GamePage>
    with SingleTickerProviderStateMixin {
  Future<Game> fetchGame(id) async {
    var url =
        'https://api.rawg.io/api/games/$id?key=6c8d73cb5f7247d099a197b7f589d25f';
    // url += "&page=1&page_size=10";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final games_response = Game.fromJson(jsonDecode(response.body));
      return games_response;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  late Animation<double> animation;
  late AnimationController controller;
  late final Animation<AlignmentGeometry> alignAnimation;

  late Future<Game> futureGame;

  @override
  void initState() {
    super.initState();
    futureGame = fetchGame(widget.id);

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
    bool _isExpanded = false;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          backgroundColor: Color.fromARGB(255, 7, 51, 50),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Custom behavior here
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Color(0xFF141519),
        body: FutureBuilder<Game>(
            future: fetchGame(widget.id),
            builder: (context, snapshot) {
              try {
                var rand_color = getRandomColor();
                if (snapshot.hasData) {
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
                          0.30,
                          0.60
                        ])),
                    child: Column(
                      children: [
                        Image.network(snapshot.data!.background_image),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(height: 8),
                              Center(
                                  child: Row(
                                children: [
                                  SizedBox(width: 155),
                                  Icon(
                                    Icons.star,
                                    color: getColorFromRating(
                                        snapshot.data!.rating),
                                  ),
                                  SizedBox(width: 2),
                                  Text(snapshot.data!.rating.toString(),
                                      style: TextStyle(
                                        color: getColorFromRating(
                                            snapshot.data!.rating),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ))
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                                  min(max(1, snapshot.data!.genres.length), 2),
                              itemBuilder: (context, subIndex) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => GamesPage(
                                              title: snapshot.data!
                                                          .genres[subIndex]
                                                      ['name'] +
                                                  " games",
                                              category: snapshot.data!
                                                  .genres[subIndex]['name']
                                                  .toString()
                                                  .toLowerCase(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        snapshot.data!.genres[subIndex]['name'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      style: ButtonStyle(
                                          fixedSize: MaterialStateProperty.all(
                                              const Size(115, 40)),
                                          backgroundColor:
                                              MaterialStatePropertyAll<Color>(
                                                  Color.fromARGB(
                                                      175, 55, 73, 87)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          )))),
                                );
                              },
                            )),
                        SizedBox(height: 20),
                        ExpandableText(
                          text: snapshot.data!.description
                              .replaceAll('<p>', '')
                              .replaceAll('<br />', '')
                              .replaceAll('</p>', ''),
                          maxLines: 3,
                        )
                      ],
                    ),
                  )));
                } else if (snapshot.hasError) {
                  // If there is an error, display it
                  return Center(
                      child: Text(
                    'This page could not load',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ));
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
