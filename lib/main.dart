import 'package:blog_app/screens/upload_blog_page.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Blog App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFAA002F),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        UploadBlogPage.routeName: (context) => const UploadBlogPage(),
      },
    );
  }
}
