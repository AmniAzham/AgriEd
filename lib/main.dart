import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_core/firebase_core.dart';

//import 'firebase_options.dart';
import 'pages/home/saved_items_service.dart';
import 'pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);

  final savedItemsService = SavedItemsService();
  await savedItemsService.loadSavedItems();

  runApp(
    ChangeNotifierProvider.value(
      value: savedItemsService,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriEd',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 57, 167, 117),
        fontFamily: 'Outfit',
      ),
      home: const SplashPage(),
    );
  }
}