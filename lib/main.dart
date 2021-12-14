import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/pages/homepage.dart';
import 'package:marsyeats/servises/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'package:splash_screen_view/ColorizeAnimatedText.dart';
// import 'package:splash_screen_view/ScaleAnimatedText.dart';
// import 'package:splash_screen_view/SplashScreenView.dart';
// import 'package:splash_screen_view/TyperAnimatedText.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StartingApp());
}

class StartingApp extends StatefulWidget {
  @override
  _StartingAppState createState() => _StartingAppState();
}

class _StartingAppState extends State<StartingApp> {
  bool signIn = false;
  Widget nextPage = Scaffold(
    body: Container(
      color: Colors.green,
      width: double.infinity,
      height: double.infinity,
    ),
  );
  late Widget page;

  Widget sign() {
    getUser().then(
      (user) => setState(
        () {
          page = Homepage(name: user!.displayName ?? '');
          signIn = true;
        },
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.white38,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/splash.png'),
            ),
            Text(
              'Выполняется вход в Google аккаут',
              style: TextStyle(
                fontSize: 20,
                color: Colors.lightGreenAccent[300],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataMeal>(
      create: (context) => DataMeal(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueAccent,
          textTheme: TextTheme(
            caption: TextStyle(
              fontSize: 16.0,
              color: Colors.blue,
            ),
          ),
        ),
        darkTheme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
            caption: TextStyle(
              fontSize: 16.0,
              color: Colors.white38,
            ),
          ),
        ),
        color: Colors.cyanAccent,
        home: SafeArea(
          child: signIn ? page : sign(), //Homepage(),
        ),
      ),
    );
  }
}
