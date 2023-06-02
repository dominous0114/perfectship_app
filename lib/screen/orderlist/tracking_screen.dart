import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/custom_appbar.dart';

class TrackingScreen extends StatefulWidget {
  final String url;
  final String path;
  final String trackingNo;
  const TrackingScreen({
    Key? key,
    required this.url,
    required this.path,
    required this.trackingNo,
  }) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  // @override
  // void initState() {
  //   isLoading = true;
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  //   if (Platform.isIOS) WebView.platform = CupertinoWebView();
  //   print('url =${widget.url}${widget.path}${widget.trackingNo}');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'ติดตามสถานะ',
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
      body: Stack(
        children: [
          // WebView(
          //   key: _key,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: '${widget.url}${widget.path}${widget.trackingNo}',
          //   onPageFinished: (finish) {
          //     setState(() {
          //       isLoading = false;
          //     });
          //   },
          // ),
          isLoading
              ? Center(
                  child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
