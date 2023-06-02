import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../../config/constant.dart';
import '../../widget/custom_appbar.dart';

class PdfBillListScreen extends StatefulWidget {
  static const String routeName = '/pdfbillList';
  static Route route({required String pdfData}) {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => PdfBillListScreen(
              pdfData: pdfData,
            ));
  }

  final String pdfData;
  const PdfBillListScreen({
    Key? key,
    required this.pdfData,
  }) : super(key: key);
  @override
  State<PdfBillListScreen> createState() => _PdfBillListScreenState();
}

class _PdfBillListScreenState extends State<PdfBillListScreen> with SingleTickerProviderStateMixin {
  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  String url = '';
  final urlController = TextEditingController();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;

  final key = GlobalKey();
  File? file;

  late Animation<double> _animation;
  late AnimationController _animationController;

  var loadingPercentage = 0;
  late File xFile;
  String percentage = '';

  bool isLoading = false;

  //late WebViewController _controller;
  var dio = Dio();
  String urlShare = 'trackId';

  final _key = UniqueKey();
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    //url = '${server.ENV}/print/$paperSize?order=${widget.pdfData}';
    url = '${MyConstant().newDomain}/print/print-bill/${widget.pdfData}/100';

    // getPDF();

    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(
          hideDefaultSystemContextMenuItems: false,
        ),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid) ? contextMenuItemClicked.androidId : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " + id.toString() + " " + contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.pdfData,
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomAppBar(
        elevation: 50,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: GestureDetector(
            onTap: () async {
              webViewController!.evaluateJavascript(source: 'window.print()');
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        webViewController!.evaluateJavascript(source: 'window.print()');
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.print,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('ปริ้นท์', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: GestureDetector(
                //       onTap: () async {
                //         if (Platform.isAndroid) {
                //           _openOption(context);
                //           //print('xfile = ${widget.xFile}');
                //         } else {
                //           await CustomShare.shareUrl(url);
                //         }
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 1)]),
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Platform.isAndroid
                //                   ? Icon(
                //                       Icons.share,
                //                       color: Colors.blue,
                //                     )
                //                   : Icon(
                //                       CupertinoIcons.share,
                //                       color: Colors.blue,
                //                     ),
                //               SizedBox(
                //                 width: 5,
                //               ),
                //               Text('แชร์(Share)', style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold)),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        //SelectableText(url),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     children: [
        //       Text(
        //         "ปริ้น : ",
        //         style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //               fontSize: PlatformSize(context),
        //             ),
        //       ),
        //       Expanded(
        //         child: CupertinoButton(
        //           padding: EdgeInsets.zero,
        //           onPressed: () {},
        //           child: Container(
        //             width: MediaQuery.of(context).size.width,
        //             padding: EdgeInsets.symmetric(horizontal: 8),
        //             height: 40,
        //             decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        //             child: DropdownButtonHideUnderline(
        //               child: DropdownButton2<PaperSizeModel>(
        //                 //dropdownColor: Theme.of(context).primaryColor,
        //                 dropdownElevation: 8,
        //                 scrollbarRadius: const Radius.circular(40),
        //                 dropdownMaxHeight: 400,
        //                 scrollbarThickness: 6,
        //                 scrollbarAlwaysShow: true,
        //                 offset: const Offset(0, -20),
        //                 dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white),
        //                 buttonDecoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(14),
        //                 ),
        //                 style: Theme.of(context)
        //                     .textTheme
        //                     .bodyText1!
        //                     .copyWith(fontSize: PlatformSize(context), color: Colors.grey[600], fontWeight: FontWeight.bold),
        //                 hint: Text(
        //                   "  ",
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .bodyText1!
        //                       .copyWith(fontSize: PlatformSize(context), color: Colors.grey[600], fontWeight: FontWeight.bold),
        //                 ),
        //                 items: PaperSizeModel.paperSizes.map<DropdownMenuItem<PaperSizeModel>>((e) {
        //                   return DropdownMenuItem(
        //                     value: e,
        //                     child: Text(
        //                       e.upper,
        //                       style: Theme.of(context)
        //                           .textTheme
        //                           .headline3!
        //                           .copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold, color: Colors.black87),
        //                     ),
        //                   );
        //                 }).toList(),
        //                 isDense: true,
        //                 onChanged: (value) {
        //                   setState(() {
        //                     print(value);
        //                     selectIndex = value!;
        //                     title = value.upper;
        //                     setPaper(paper: value);
        //                   });
        //                 },
        //                 value: selectIndex,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: CupertinoButton(
        //             padding: EdgeInsets.all(0),
        //             child: Row(
        //               children: [
        //                 Text(
        //                   ' คัดลอก',
        //                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
        //                         fontSize: PlatformSize(context),
        //                       ),
        //                 ),
        //                 SizedBox(width: 5),
        //                 Icon(
        //                   Icons.copy,
        //                   color: Theme.of(context).iconTheme.color,
        //                 ),
        //               ],
        //             ),
        //             onPressed: () {
        //               Clipboard.setData(ClipboardData(text: url)).then((_) {
        //                 ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //                     content: Text(
        //                   "คัดลอก Link $url แล้ว",
        //                   style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.white),
        //                 )));
        //               });
        //             }),
        //       )
        //     ],
        //   ),
        // ),
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: 'download',
                child: InAppWebView(
                  key: webViewKey,
                  contextMenu: contextMenu,
                  initialUrlRequest: URLRequest(url: Uri.parse(url)),
                  // initialFile: "assets/index.html",
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialOptions: options,
                  pullToRefreshController: pullToRefreshController,

                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  androidOnPermissionRequest: (controller, origin, resources) async {
                    return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (!["http", "https", "file", "chrome", "data", "javascript", "about"].contains(uri.scheme)) {
                      if (await canLaunch(url)) {
                        // Launch the App
                        await launch(
                          url,
                          forceWebView: true,
                        );
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    pullToRefreshController.endRefreshing();
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onLoadError: (controller, url, code, message) {
                    pullToRefreshController.endRefreshing();
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = this.url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
