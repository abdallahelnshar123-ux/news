import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/utils/screen_size.dart';

class PageNavigationWidget extends StatelessWidget {
  final int pageNum;
  final VoidCallback onPressed;
  final bool visibility;

  final String text;

  const PageNavigationWidget({
    super.key,
    required this.pageNum,
    required this.onPressed,
    required this.text,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: context.height * 0.015),
        ),
        onPressed: onPressed,
        child: Text(
          context.tr(text),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
