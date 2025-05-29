import 'package:flutter/material.dart';

class Akkaunt extends StatefulWidget {
  const Akkaunt({super.key});

  @override
  State<Akkaunt> createState() => _AkkauntState();
}

class _AkkauntState extends State<Akkaunt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: Center(child: Icon(Icons.person)));
  }
}
