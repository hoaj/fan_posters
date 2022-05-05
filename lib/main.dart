import 'package:fan_posters/models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:fan_posters/common/theme.dart';
import 'package:fan_posters/screens/posters_screen.dart';
import 'package:fan_posters/screens/favorites_screen.dart';
import 'package:provider/provider.dart';
import 'package:fan_posters/models/posters_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PostersModel>(
          create: (BuildContext context) => PostersModel(),
        ),
        ChangeNotifierProvider<FavoritesModel>(
          create: (BuildContext context) => FavoritesModel(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool>? _future;

  @override
  void initState() {
    super.initState();
    _future = Provider.of<PostersModel>(context, listen: false).firstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fan Posters Collection',
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => FutureBuilder(
              future: _future,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) =>
                  snapshot.hasData
                      ? const PostersScreen()
                      : const Scaffold(
                          body: Center(child: CircularProgressIndicator())),
            ),
        "/favorites": (context) => const FavoritesScreen(),
      },
    );
  }
}
