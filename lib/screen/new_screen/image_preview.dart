import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfectship_app/widget/fontsize.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';

class PhotoWidget extends StatefulWidget {
  final String path;
  static const String routeName = '/photo-widget';

  static Route route({required String path}) {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => PhotoWidget(
        path: path,
      ),
    );
  }

  const PhotoWidget({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  State<PhotoWidget> createState() => _PhotoWidgetState();
}

class _PhotoWidgetState extends State<PhotoWidget> {
  String percentage = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        title: Text(
          'รูปภาพ',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.black,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.path),
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
              value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
            ),
          ),
        ),
        heroAttributes: PhotoViewHeroAttributes(tag: widget.path),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: percentage == ''
            ? Icon(
                Icons.save_alt,
                color: Colors.blueAccent,
              )
            : Text(
                '${percentage} %',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: PlatformSize(context), color: Colors.black),
              ),
        onPressed: () async {
          Map<Permission, PermissionStatus> statuses = await [
            Permission.storage,
            //add more permission to request here.
          ].request();

          if (statuses[Permission.storage]!.isGranted) {
            final appDir = await getApplicationDocumentsDirectory();
            String savename = "${DateTime.now()}.png";
            String savePath = appDir.path + "/$savename";
            try {
              await Dio().download(widget.path, savePath, onReceiveProgress: (received, total) {
                if (total != -1) {
                  print((received / total * 100).toStringAsFixed(0) + "%");
                  setState(() {
                    percentage = (received / total * 100).toStringAsFixed(0);
                  });
                  //you can build progressbar feature too
                }
              });

              GallerySaver.saveImage(savePath).then((success) {
                setState(() {
                  Fluttertoast.showToast(
                      msg: 'บันทึกแล้ว!!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  /*ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(
                      content: Text(
                        'บันทึกแล้ว!!',
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: Colors.white),
                      )));*/
                  percentage = '';
                });
              });
            } on DioError catch (e) {
              print(e.message);
            }
          } else {
            print("No permission to read and write.");
          }
        },
      ),
    );
  }
}
