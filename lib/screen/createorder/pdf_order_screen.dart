import 'dart:collection';

import 'dart:io';

import 'dart:ui';

import 'package:android_intent_plus/android_intent.dart';

import 'package:dio/dio.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:perfectship_app/config/constant.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/custom_appbar.dart';
import '../../widget/fontsize.dart';
import 'new_widget/custom_share.dart';

class PdfOrderScreen extends StatefulWidget {
  static const String routeName = '/pdforder';

  static Route route({required String pdfData}) {
    return PageRouteBuilder(
        settings: RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => PdfOrderScreen(
              pdfData: pdfData,
            ));
  }

  final String pdfData;
  const PdfOrderScreen({
    Key? key,
    required this.pdfData,
  }) : super(key: key);

  @override
  State<PdfOrderScreen> createState() => _PdfOrderScreenState();
}

class _PdfOrderScreenState extends State<PdfOrderScreen> with SingleTickerProviderStateMixin {
  String title = 'A6';
  String paperSize = 'a6';
  PaperSizeModel selectIndex = PaperSizeModel.paperSizes.first;

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
    url = '${MyConstant().newDomain}/print/$paperSize?order=${widget.pdfData}';

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

  void _selectPrint() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        )),
        context: context,
        builder: (context) {
          return SafeArea(
            child: StatefulBuilder(
              builder: (BuildContext context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          AndroidIntent intent = AndroidIntent(
                            action: 'action_view',
                            data: url, // Facebook app URL scheme
                            package: 'cn.paperang.international', // Package name of the Facebook app
                          );
                          intent.launch().catchError((e) {
                            launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=cn.paperang.international&hl=en&gl=US'), mode: LaunchMode.externalApplication);

                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://play-lh.googleusercontent.com/49MUDDMLwLdAUbU3YsJz9TH1AGtc2OisjKJCLiPsx0MrNI1th0Co4Jqzy-8zlcrjNw=s96-rw',
                                        width: 50,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Paperang',
                                    style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(),
                      ),
                      GestureDetector(
                        onTap: () async {
                          //context.loaderOverlay.show();
                          await Future.delayed(Duration(seconds: 2));
                          await Share.share(url);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      'https://play-lh.googleusercontent.com/nDKrKLdZopeZtkyV1kGK0MUF-DPzl8Z9c5rc5osYxrpRkHTdVC7Oo-vUw6mqZuSIfg=w480-h960-rw',
                                      width: 50,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PeriPage',
                                      style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '**แชร์ไปยังแอพพลิเคชั่น PeriPage เพื่อทำรายการต่อ',
                                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  Future setPaper({required PaperSizeModel paper}) async {
    setState(() {
      paperSize = paper.lower;
      url = '${MyConstant().newDomain}/print/$paperSize?order=${widget.pdfData}';
      urlController.text = url;
      webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black54,
            )),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontSize: PlatformSize(context) * 1.2,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.black54,
            )
          ]
              // gradient: LinearGradient(
              //   colors: [
              //     Color.fromARGB(200, 43, 166, 223),
              //     Color.fromARGB(180, 41, 88, 162),
              //   ],
              //   begin: Alignment.topLeft,
              //   end: Alignment.topRight,
              //   stops: [0.0, 0.8],
              //   tileMode: TileMode.clamp,
              // ),
              ),
        ),
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomAppBar(
        elevation: 50,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: GestureDetector(
            onTap: () async {
              if (paperSize == 'paperang' || paperSize == 'paperang_lan') {
                //Navigator.push(context, CupertinoPageRoute(builder: (context) => PaperangScreen(xFile: url)));
              } else if (paperSize == 'pdf') {
                launch(url);
              } else {
                //saveWebViewContentAsPdf();
                webViewController!.evaluateJavascript(source: 'window.print()');
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Visibility(
                  visible: paperSize == 'paperang' ? false : true,
                  child: Expanded(
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (Platform.isAndroid) {
                          _selectPrint();
                          //print('xfile = ${widget.xFile}');
                        } else {
                          await CustomShare.shareUrl(url);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 1)]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Platform.isAndroid
                                  ? Icon(
                                      Icons.share,
                                      color: Colors.blue,
                                    )
                                  : Icon(
                                      CupertinoIcons.share,
                                      color: Colors.blue,
                                    ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('แชร์(Share)', style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "ปริ้น : ",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: PlatformSize(context),
                    ),
              ),
              Expanded(
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    height: 40,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<PaperSizeModel>(
                        //dropdownColor: Theme.of(context).primaryColor,
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        dropdownMaxHeight: 400,
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(0, -20),
                        dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: Colors.white),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.grey[600], fontWeight: FontWeight.bold),
                        hint: Text(
                          "  ",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.grey[600], fontWeight: FontWeight.bold),
                        ),
                        items: PaperSizeModel.paperSizes.map<DropdownMenuItem<PaperSizeModel>>((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.upper,
                              style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: PlatformSize(context), fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          );
                        }).toList(),
                        isDense: true,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            selectIndex = value!;
                            title = value.upper;
                            setPaper(paper: value);
                          });
                        },
                        value: selectIndex,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Text(
                          ' คัดลอก',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: PlatformSize(context),
                              ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.copy,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: url)).then((_) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "คัดลอก Link $url แล้ว",
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.white),
                        )));
                      });
                    }),
              )
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: 'download',
                child: InAppWebView(
                  key: webViewKey,
                  contextMenu: contextMenu,
                  initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(url))),
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

  _openOption(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
          title: const Text('เลือกตัวเลือก'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/49MUDDMLwLdAUbU3YsJz9TH1AGtc2OisjKJCLiPsx0MrNI1th0Co4Jqzy-8zlcrjNw=s96-rw',
                        width: 50,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Paperang',
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ],
              ),
              onPressed: () async {
                AndroidIntent intent = AndroidIntent(
                  package: 'cn.paperang.international',
                  action: 'action_view',
                  data: url,
                );

                await intent.launch().catchError((e) {
                  launchUrl(Uri.parse('https://play.google.com/store/apps/details?id=cn.paperang.international&hl=en&gl=US'), mode: LaunchMode.externalApplication);
                });
              },
            ),
            CupertinoActionSheetAction(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://play-lh.googleusercontent.com/nDKrKLdZopeZtkyV1kGK0MUF-DPzl8Z9c5rc5osYxrpRkHTdVC7Oo-vUw6mqZuSIfg=w480-h960-rw',
                        width: 50,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PeriPage',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Text(
                        '**แชร์ไปยัง PeriPage เพื่อทำรายการต่อ',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: () async {
                //await Future.delayed(Duration(seconds: 2));
                await Share.share(url);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
          )),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
              Text(
                'กำลังโหลด',
                style: Theme.of(context).textTheme.headline3,
              )
            ],
          ),
        ),
      );
}

class PaperSizeModel {
  final String upper;
  final String lower;

  PaperSizeModel({
    required this.upper,
    required this.lower,
  });

  static final paperSizes = [
    PaperSizeModel(
      upper: 'A6 (100x150)',
      lower: 'a6',
    ),
    PaperSizeModel(
      upper: 'A7 (100x75)',
      lower: 'a7',
    ),

    PaperSizeModel(upper: 'Paperang', lower: 'paperang')

    // PaperSizeModel(
    //   upper: 'PDF',
    //   lower: 'pdf',
    // ),
  ];
}
