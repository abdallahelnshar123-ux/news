import 'package:flutter/material.dart';
import 'package:news/category_details/category_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CategoryDetails());
  }
}
