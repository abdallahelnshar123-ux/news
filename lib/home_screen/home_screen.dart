import 'package:flutter/material.dart';
import 'package:news/home_screen/category_details/category_details.dart';
import 'package:news/home_screen/widget/category_item.dart';
import 'package:news/model/category.dart';
import 'package:news/utils/screen_size.dart';


class HomeScreen extends StatelessWidget {
  List<Category> categoryList = [];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    categoryList = Category.getCategoryList();
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
        child: Column(
          spacing: context.height*0.02,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Good Morning',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            FittedBox(
              child: Text(
                'Here is Some News For You',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: CategoryDetails(),

              // ListView.separated(
              //   itemBuilder: (context, index) =>
              //       CategoryItem(index: index, category: categoryList[index]),
              //   separatorBuilder: (context, index) => SizedBox(height: context.height*0.02,),
              //   itemCount: categoryList.length,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
