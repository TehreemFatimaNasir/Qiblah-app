import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

void main() {
  runApp(const QiblaApp());
}

class QiblaApp extends StatelessWidget {
  const QiblaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qibla Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const SplashScreen(),
    );
  }
}



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  QiblaCompassScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('images/qibla.png'),
              width: 200,
              height: 200,
              color: Colors.blueGrey,
            ),
            SizedBox(height: 30),
            Text(
              'Welcome To Qibla Finder App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({super.key});

  @override
  State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  double _angle = 0;
  late StreamSubscription<QiblahDirection> _qiblahStream;

  @override
  void initState() {
    super.initState();

    _qiblahStream = FlutterQiblah.qiblahStream.listen((direction) {
      setState(() {
        _angle = direction.qiblah * (-pi / 180);
      });
    });
  }

  @override
  void dispose() {
    _qiblahStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Qibla Compass'),
        centerTitle: true,
      ),
      body: Center(
        child: Transform.rotate(
          angle: _angle,
          child: Image.asset(
            'images/qibla_image.png',
            width: 250,
            height: 250,
          ),
        ),
      ),
    );
  }
}
