import 'package:flutter/material.dart';
import 'package:news/home_screen/category_details/source/source_tab_widget.dart';
import 'package:news/home_screen/search/search_news_widget.dart';
import 'package:news/model/source_response.dart';



class SearchSourceWidget extends StatefulWidget {
  final List<Source> sourcesList;
  final String keyWord ;

  const SearchSourceWidget({super.key, required this.sourcesList , required this.keyWord});

  @override
  State<SearchSourceWidget> createState() => _SearchSourceWidgetState();
}

class _SearchSourceWidgetState extends State<SearchSourceWidget> {
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
          // SearchNewsWidget(source: widget.sourcesList[selectedIndex] , keyWord: widget.keyWord,),

        ],
      ),
    );
  }
}
