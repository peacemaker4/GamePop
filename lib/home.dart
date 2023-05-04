import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_app/categories.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'devices.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CategoriesPage(
                        title: "Categories",
                      ),
                    ),
                  );
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
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: SingleChildScrollView(
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
                                          padding: EdgeInsets.only(top: 17),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 0),
                                                  child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'Competitive',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(const Size(
                                                                      115, 40)),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Color.fromARGB(
                                                                      175,
                                                                      55,
                                                                      73,
                                                                      87)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          )))),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 18),
                                                  child: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                        'FPS',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(const Size(
                                                                      115, 40)),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Color.fromARGB(
                                                                      175,
                                                                      55,
                                                                      73,
                                                                      87)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          )))),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 18),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Devices(),
                                                          ),
                                                        );
                                                      },
                                                      child: Text(
                                                        'Devices',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      style: ButtonStyle(
                                                          fixedSize:
                                                              MaterialStateProperty
                                                                  .all(const Size(
                                                                      115, 40)),
                                                          backgroundColor:
                                                              MaterialStatePropertyAll<
                                                                      Color>(
                                                                  Color.fromARGB(
                                                                      175,
                                                                      55,
                                                                      73,
                                                                      87)),
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          )))),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 17),
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
                                                            'https://www.esports.net/wp-content/uploads/2022/06/LoL.jpg',
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
                                                            'https://cdn.akamai.steamstatic.com/steam/apps/252490/ss_e825b087b95e51c3534383cfd75ad6e8038147c3.1920x1080.jpg?t=1678981332',
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
                                                              "Survival",
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
                                                          'https://cdn.cloudflare.steamstatic.com/steam/apps/1426300/ss_368e275491bce7f2d43ce32bc451eede42d176ad.600x338.jpg?t=1617173513',
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
                                                            "Rogue-like",
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
                                                          'https://images.blz-contentstack.com/v3/assets/bltf408a0557f4e4998/bltbbe5c06732b67f46/63b5c30aabb62a10ccecdf67/call-of-duty-modern-warfare-ii-section1-feature1.jpg?width=640&format=webply&dpr=2&disable=upscale&quality=80',
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
                                                            "Action",
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
                                                          'https://assets.nintendo.com/image/upload/ar_16:9,b_auto:border,c_lpad/b_white/f_auto/q_auto/dpr_2.0/c_scale,w_400/ncom/software/switch/70010000012332/8b42e00012633320624f3894179b5d6bec44c255998a58ceb54e07bd352df171',
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
                                                            "Fighting",
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
                                                          'https://cdn.cloudflare.steamstatic.com/steam/apps/292030/ss_849ec8dcc6f8df1c0b2c509584c9fc9e51f88cfa.600x338.jpg?t=1675178392',
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
                                                            "Adventure",
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
                                      AlignTransition(
                                          alignment: alignAnimation,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 32),
                                            child: Text(
                                              'Popular',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                              textAlign: TextAlign.end,
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 0, right: 12),
                                                    child: InkWell(
                                                        onTap: () {
                                                          print(
                                                              "Category pressed");
                                                        },
                                                        child: Container(
                                                            width: 378,
                                                            height: 185,
                                                            child: Card(
                                                              semanticContainer:
                                                                  true,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              child:
                                                                  Image.network(
                                                                'https://i.ibb.co/b2qZRkr/Group-34.png',
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                            )))),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 25,
                                                        bottom: 25,
                                                        right: 12),
                                                    child: InkWell(
                                                        onTap: () {
                                                          print(
                                                              "Category pressed");
                                                        },
                                                        child: Container(
                                                            width: 375,
                                                            height: 185,
                                                            child: Card(
                                                              semanticContainer:
                                                                  true,
                                                              clipBehavior: Clip
                                                                  .antiAliasWithSaveLayer,
                                                              child:
                                                                  Image.network(
                                                                'https://i.ibb.co/TRFdfRM/Group-37.png',
                                                                fit: BoxFit
                                                                    .fitHeight,
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25),
                                                              ),
                                                            ))))
                                              ]))
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
