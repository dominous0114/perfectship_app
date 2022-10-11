import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/custom_appbar.dart';

class TrackHome extends StatefulWidget {
  final String url;
  final String path;
  final String trackingNo;
  const TrackHome(
      {Key? key,
      required this.url,
      required this.path,
      required this.trackingNo})
      : super(key: key);

  @override
  State<TrackHome> createState() => _TrackHomeState();
}

class _TrackHomeState extends State<TrackHome> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
    print('url =${widget.url}${widget.path}${widget.trackingNo}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ติดตามสถานะ',
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
