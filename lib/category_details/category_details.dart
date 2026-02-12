import 'package:flutter/material.dart';
import 'package:news/api/api_manager.dart';
import 'package:news/model/source_response.dart';
import 'package:news/utils/App_Colors.dart';
import 'package:news/utils/app_styles.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse>(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.grayColor),
          );
        } else if (snapshot.hasError) {
          return Column(
            children: [
              Text(
                'something went wrong',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources();
                  setState(() {

                  });
                },
                child: Text('try again', style: AppStyles.bold16white),
              ),
            ],
          );
        }
        if (snapshot.data?.status != 'ok') {
          return Column(
            children: [
              Text(
                snapshot.data!.message!,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              ElevatedButton(
                onPressed: () {
                  ApiManager.getSources();
                  setState(() {

                  });
                },
                child: Text('try again', style: AppStyles.bold16white),
              ),
            ],
          );
        }
        var sourcesList = snapshot.data!.sources!;
        return ListView.builder(
          itemBuilder: (context, index) {
            return Text(sourcesList[index].name ?? 'no data');
          },
          itemCount: sourcesList.length,
        );
      },
    );
  }
}
