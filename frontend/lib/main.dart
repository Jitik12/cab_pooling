import 'package:flutter/material.dart';
import 'package:swift_street/Views/User_interface/cab_pooling.dart';
import 'package:swift_street/Views/User_interface/home_page.dart';
import 'package:swift_street/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        cabPoolingHome: (context) => const CabPoolingPage(),
      }));
}

