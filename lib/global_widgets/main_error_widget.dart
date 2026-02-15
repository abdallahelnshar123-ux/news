import 'package:flutter/material.dart';

import '../api/api_manager.dart';
import '../utils/app_styles.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed ;
  const MainErrorWidget({super.key  , required this.errorMessage , required this.onPressed });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        ElevatedButton(
          onPressed: onPressed ,
          child: Text('try again', style: AppStyles.bold16white),
        ),
      ],
    );
  }
}
