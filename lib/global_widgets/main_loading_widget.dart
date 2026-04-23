import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

class MainLoadingWidget extends StatelessWidget {
  const MainLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.only(top: context.height *0.35),
      child: CircularProgressIndicator(),
    ) ;
  }
}
