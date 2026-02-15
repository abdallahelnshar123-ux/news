import 'package:flutter/material.dart';
import 'package:news/model/source_response.dart';

class SourceTab extends StatelessWidget {
  final Source source;

  final bool isSelected;

  const SourceTab({super.key, required this.source, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      source.name ?? 'no data ',
      style: isSelected
          ? Theme.of(context).textTheme.titleMedium
          : Theme.of(context).textTheme.titleSmall,
    );
  }
}
