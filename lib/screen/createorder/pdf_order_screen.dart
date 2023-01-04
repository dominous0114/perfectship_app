import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_intent_plus/android_intent.dart';
import 'package:device_apps/device_apps.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfectship_app/config/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../widget/custom_appbar.dart';
import '../../widget/fontsize.dart';

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
  String title = 'A4';

  String selectIndex = 'A4';

  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  String url = '';
  final urlController = TextEditingController();
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true, mediaPlaybackRequiresUserGesture: true, useOnDownloadStart: true),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

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

  var dio = Dio();
  String urlShare = 'trackId';

  ReceivePort receiveport = ReceivePort();
  final ReceivePort _port = ReceivePort();

  PaperSizeModel? _papersize = PaperSizeModel.paperSizes.first;

  void _onDropDownItemSelectedCategory(PaperSizeModel newSelected) {
    setState(() {
      _papersize = newSelected;
      print('papersize = ${_papersize!.lower}');
    });
  }

  @override
  void initState() {
    // IsolateNameServer.registerPortWithName(receiveport.sendPort, 'downloadpdf');

    // receiveport.listen((message) {
    //   setState(() {
    //     progress = message;
    //   });
    // });
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    url = 'https://customer.perfectship.cloud/print/${_papersize!.lower}?order=${widget.pdfData}';
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
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
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

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future setPaper({required String paper}) async {
    setState(() {
      url = 'https://customer.perfectship.cloud/print/${_papersize!.lower}?order=${widget.pdfData}';
      urlController.text = url;
      webViewController?.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
    });
  }

  @override
  Widget build(BuildContext context) {
    // _createFileFromBase64(
    //     String base64content, String fileName, String yourExtension) async {
    //   var bytes = base64Decode(base64content.replaceAll('\n', ''));
    //   final output = await getExternalStorageDirectory();
    //   final file = File("${output!.path}/$fileName.$yourExtension");
    //   await file.writeAsBytes(bytes.buffer.asUint8List());
    //   print("${output.path}/${fileName}.$yourExtension");
    //   await OpenFile.open("${output.path}/$fileName.$yourExtension");
    //   setState(() {});
    // }

    Future<void> share() async {
      await FlutterShare.share(
          title: 'Example share', text: 'Example share text', linkUrl: 'https://flutter.dev/', chooserTitle: 'Example Chooser Title');
    }

    Future<void> launchURL(String url) async {
      if (await canLaunchUrlString(
        url,
      )) {
        // Passes the URL to the OS to be handled by another application.
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    return !isLoading
        ? Scaffold(
            // drawer: myDrawer(context: context),
            appBar: CustomAppBar(
              title: title,
              backArrow: true,
              onPressArrow: () {
                Navigator.pop(context);
              },
            ),
            body: Column(
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField2(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Text(
                                    '--โปรดเลือกประเภทพัสดุ--',
                                    style: TextStyle(
                                      fontSize: PlatformSize(context),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            value: _papersize,
                            items: PaperSizeModel.paperSizes
                                .map((item) => DropdownMenuItem<PaperSizeModel>(
                                      value: item,
                                      child: Text(
                                        item.upper,
                                        style: TextStyle(
                                          fontSize: PlatformSize(context),
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              _onDropDownItemSelectedCategory(value as PaperSizeModel);
                              setState(() {
                                selectIndex = value.lower;
                                title = value.upper;
                                setPaper(paper: value.lower);
                              });
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              errorStyle:
                                  Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black26,
                              ),
                              color: Colors.white,
                            ),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black45,
                              size: 20,
                            ),
                            iconSize: 30,
                            buttonHeight: 45,
                            buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                            dropdownDecoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            dropdownMaxHeight: 250,
                            scrollbarAlwaysShow: true,
                            scrollbarThickness: 6,
                          ),
                          // CustomDropdownButton2(
                          //   hint: 'Select Item',
                          //   buttonDecoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey),
                          //       borderRadius: BorderRadius.circular(10),
                          //       color: Colors.white),
                          //   icon: Icon(Icons.keyboard_arrow_down_rounded),
                          //   dropdownItems: PaperSizeModel.paperSizes
                          //       .map((e) => e.upper)
                          //       .toList(),
                          //   value: PaperSizeModel.paperSizes,
                          //   onChanged: (value) {
                          // setState(() {
                          //   selectIndex = value!;
                          //   title = value;
                          //   setPaper(paper: value.toLowerCase());
                          //     });
                          //   },
                          // ),
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
                          initialUrlRequest: URLRequest(url: Uri.parse(url)),
                          // initialFile: "assets/index.html",
                          initialUserScripts: UnmodifiableListView<UserScript>([]),
                          initialOptions: options,
                          pullToRefreshController: pullToRefreshController,
                          onWebViewCreated: (controller) {
                            webViewController = controller;
                            // webViewController!.addJavaScriptHandler(
                            //   handlerName: 'serverSideJsFuncName',
                            //   callback: (data) async {
                            //     if (data.isNotEmpty) {
                            //       final String receivedFileInBase64 = data[0];
                            //       final String receivedMimeType = data[1];

                            //       // NOTE: create a method that will handle your extensions
                            //       final String yourExtension =
                            //           'application/pdf'; // 'pdf'

                            //       _createFileFromBase64(receivedFileInBase64,
                            //           'YourFileName', yourExtension);
                            //     }
                            //   },
                            // );
                          },
                          onLoadStart: (controller, url) {
                            setState(() {
                              this.url = url.toString();
                              urlController.text = this.url;
                            });
                          },

                          // onDownloadStart: (controller, url) async {
                          //   Directory? tempDir =
                          //       await getExternalStorageDirectory();
                          //   print("onDownload $url");
                          //   await FlutterDownloader.enqueue(
                          //     url: url.toString(),
                          //     savedDir: tempDir!.path,
                          //     showNotification: true,
                          //     openFileFromNotification: true,
                          //     saveInPublicStorage: true,
                          //   );
                          // },
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
            ),

            // bottomNavigationBar: BottomAppBar(
            //   color: Theme.of(context).appBarTheme.backgroundColor,
            //   child: Container(
            //     decoration: BoxDecoration(color: Colors.white, boxShadow: [
            //       BoxShadow(
            //           offset: Offset.zero,
            //           spreadRadius: .2,
            //           color: Colors.grey.shade400)
            //     ]),
            //   ),
            // ),

            // onPressed: () async {
            //           if (paperSize == 'paperang') {
            //             if (Platform.isAndroid) {
            //               _openJioSavaan();
            //             } else {
            //               launch(url);
            //             }
            //           } else {
            //             webViewController!
            //                 .evaluateJavascript(source: 'window.print()');
            //           }
            //         },

            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).appBarTheme.backgroundColor,
              shape: CircularNotchedRectangle(),
              child: Container(
                decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.black54)], color: Colors.white),
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (_papersize!.lower == 'paperang') {
                        if (Platform.isAndroid) {
                          _openJioSavaan();
                        } else {
                          Clipboard.setData(ClipboardData(text: url)).then((_) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "คัดลอก Link $url แล้ว",
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.white),
                            )));
                          });
                        }
                      } else {
                        webViewController!.evaluateJavascript(source: 'window.print()');
                        // .evaluateJavascript(source: ('generatePDF()'));
                        // "var today = new Date();var dd = String(today.getDate()).padStart(2, ‘0’);var mm = String(today.getMonth() + 1).padStart(2, ‘0’); //January is 0!var yyyy = today.getFullYear();today = dd + ‘-’ + mm + ‘-’ + yyyy;const element = document.getElementById(‘page’);let nbPages = 3;var opt = {margin:       0,filename:     today,image:        { type: ‘jpeg’, quality: 0.98 },html2canvas:  { scale: 2},jsPDF:        { unit: ‘mm’, format: ‘a5’, orientation: ‘p’ },pagebreak: { mode: ‘avoid-all’, after:‘.page-break’ }};html2pdf().set(opt).from(element).save();console.log(‘pdf’)");
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.centerLeft, colors: <Color>[
                            Color.fromARGB(180, 41, 88, 162),
                            Color.fromARGB(200, 43, 166, 223),
                          ]),
                        ),
                        child: _papersize!.lower == 'paperang'
                            ? Platform.isIOS
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        child: Image.network(
                                            'https://play-lh.googleusercontent.com/49MUDDMLwLdAUbU3YsJz9TH1AGtc2OisjKJCLiPsx0MrNI1th0Co4Jqzy-8zlcrjNw',
                                            scale: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'คัดลอก URL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.white, fontSize: PlatformSize(context) * 1.4, fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                        child: Image.network(
                                            'https://play-lh.googleusercontent.com/49MUDDMLwLdAUbU3YsJz9TH1AGtc2OisjKJCLiPsx0MrNI1th0Co4Jqzy-8zlcrjNw',
                                            scale: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'แชร์ไปยัง Paperang',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge!
                                            .copyWith(color: Colors.white, fontSize: PlatformSize(context) * 1.4, fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.printer,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'สั่งพิมพ์',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(color: Colors.white, fontSize: PlatformSize(context) * 1.5, fontWeight: FontWeight.w900),
                                  ),
                                ],
                              )),
                  ),
                ),
              ),
            ),
          )
        : LoadingIndicator();
  }

  _openJioSavaan() async {
    bool isInstalled = await DeviceApps.isAppInstalled('cn.paperang.international');
    print('isInstalled = $isInstalled');
    if (isInstalled != false) {
      if (Platform.isAndroid) {
        AndroidIntent intent = AndroidIntent(action: 'action_view', data: url);
        await intent.launchChooser('cn.paperang.international');
      } else {
        launch(url);
      }
    } else {
      String url = Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=cn.paperang.international&hl=th&gl=US'
          : 'https://apps.apple.com/th/app/paperang/id1228042625?l=th';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
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
      upper: 'A4',
      lower: 'a4',
    ),
    PaperSizeModel(
      upper: 'A5',
      lower: 'a5',
    ),
    PaperSizeModel(
      upper: 'A6 (100x150)',
      lower: 'a6',
    ),
    PaperSizeModel(
      upper: 'A7 (100x75)',
      lower: 'a7',
    ),
    PaperSizeModel(
      upper: 'Paperang',
      lower: 'paperang',
    ),
    PaperSizeModel(
      upper: 'Letter',
      lower: 'letter',
    ),
    // PaperSizeModel(
    //   upper: 'PDF',
    //   lower: 'pdf',
    // ),
  ];
}
