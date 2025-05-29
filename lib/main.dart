import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:olx/Enter.dart';
import 'package:olx/add_item_page.dart';
import 'Login.dart';
import 'authServise.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDRmG4aEE4VN8GFRMvOGXnDOlv7_24c0vU",
        authDomain: "olxplatforma.firebaseapp.com",
        projectId: "olxplatforma",
        storageBucket: "olxplatforma.firebasestorage.app",
        messagingSenderId: "956393069366",
        appId: "1:956393069366:web:297fc2f1a1df8cd7767197",
        databaseURL: "https://olxplatforma-default-rtdb.firebaseio.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDRmG4aEE4VN8GFRMvOGXnDOlv7_24c0vU",
        authDomain: "olxplatforma.firebaseapp.com",
        projectId: "olxplatforma",
        storageBucket: "olxplatforma.firebasestorage.app",
        messagingSenderId: "956393069366",
        appId: "1:956393069366:web:297fc2f1a1df8cd7767197",
      ),
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: DetailesPage(),
      //   home:Enter()
      home:AuthServise.isLoggerIn()?HomePage():Enter()
    );
  }
}
