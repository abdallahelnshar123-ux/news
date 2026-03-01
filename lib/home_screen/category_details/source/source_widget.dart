import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home_screen/category_details/cubit/source_view_model.dart';
import 'package:news/home_screen/category_details/news/cubit/news_states.dart';
import 'package:news/home_screen/category_details/news/cubit/news_view_model.dart';
import 'package:news/home_screen/category_details/source/source_tab_widget.dart';
import 'package:news/home_screen/search_result_widget/search_news_widget.dart';
import 'package:news/model/source_response.dart';

import '../news/news_widget.dart';


class SourceWidget extends StatefulWidget {
  final List<Source> sourcesList;

  const SourceWidget({super.key, required this.sourcesList });

  @override
  State<SourceWidget> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourceWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourcesList.length,
      child: Column(
        children: [
          TabBar(
            padding: EdgeInsets.symmetric(vertical: 10),
            isScrollable: true,
            dividerColor: Colors.transparent,
            onTap: (index) {
              if (selectedIndex != index) {
                selectedIndex = index;
                setState(() {});
              }
            },
            tabs: widget.sourcesList
                .map(
                  (source) => SourceTab(
                    source: source,
                    isSelected:
                        selectedIndex == widget.sourcesList.indexOf(source),
                  ),
                )
                .toList(),
          ),
          NewsWidget(source: widget.sourcesList[selectedIndex]),

        ],
      ),
    );
  }
}
