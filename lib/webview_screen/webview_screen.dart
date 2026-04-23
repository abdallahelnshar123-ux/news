import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:news/provider/app_theme_provider.dart';
import 'package:news/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController webViewController;
  var loadingPerPercentage = 0;

  @override
  void initState() {
    super.initState();
    webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPerPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPerPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPerPercentage = 100;
            });
          },
        ),
      );
  }

  @override
  void didChangeDependencies() {
    String newsUrl = ModalRoute.of(context)!.settings.arguments as String;

    webViewController.loadRequest(Uri.parse(newsUrl));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('web_viewer')),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close_rounded),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          loadingPerPercentage < 100
              ? LinearProgressIndicator(
                  backgroundColor: AppColors.black50OpacityColor,
                  color: context.isLight
                      ? AppColors.blackColor
                      : AppColors.whiteColor,
                  value: loadingPerPercentage / 100,
                )
              : Container(),
        ],
      ),
    );
  }
}
