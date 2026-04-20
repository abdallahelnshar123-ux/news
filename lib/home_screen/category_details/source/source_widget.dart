import 'package:flutter/material.dart';
import 'package:news/home_screen/category_details/source/source_tab_widget.dart';
import 'package:news/model/source_response.dart';
import 'package:news/provider/source_provider.dart';
import 'package:provider/provider.dart';

import '../news/news_widget.dart';

class SourceWidget extends StatelessWidget {
  final List<Source> sourcesList;
  int selectedIndex = context.watch<SourceProvider>().selectedIndex;

  const SourceWidget({super.key, required this.sourcesList});

  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: sourcesList.length,
      initialIndex: selectedIndex,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.symmetric(vertical: 10),
            isScrollable: true,
            dividerColor: Colors.transparent,
            onTap: (index) {
              if (selectedIndex != index) {
                context.read<SourceProvider>().changeIndex(index);
              }
            },
            tabs: sourcesList
                .map(
                  (source) => SourceTab(
                    source: source,
                    isSelected: selectedIndex == sourcesList.indexOf(source),
                  ),
                )
                .toList(),
          ),
          NewsWidget(source: sourcesList[selectedIndex]),
        ],
      ),
    );
  }
}
