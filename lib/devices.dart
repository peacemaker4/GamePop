import 'package:flutter/material.dart';
import 'package:flutter_project_app/home.dart';
import 'package:flutter_project_app/main.dart';
import 'package:provider/provider.dart';

class Devices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userPlatform = Provider.of<UserPlatform>(context);

    return MaterialApp(
      title: 'Devices',
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF42275a), Color(0xFF734b6d)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Devices',
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          userPlatform.switchPlatform("Desktop", 4),
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: "Games",
                              ),
                            ),
                          ),
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/desktop.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.darken),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Desktop',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          userPlatform.switchPlatform("Mobile", 21),
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: "Games",
                              ),
                            ),
                          )
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/mobile.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken),
                            ),
                            color: Colors.orange,
                          ),
                          child: Center(
                            child: Text(
                              'Mobile',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () => {
                        userPlatform.switchPlatform("Portable", 7),
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                              title: "Games",
                            ),
                          ),
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/portable.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.4),
                                BlendMode.darken),
                          ),
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            'Portable ',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          userPlatform.switchPlatform("Console", 18),
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                title: "Games",
                              ),
                            ),
                          )
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: AssetImage('assets/images/console.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.darken),
                            ),
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              'Console',
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
