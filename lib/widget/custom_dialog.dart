import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/shared/types.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class CustomDialog {
  void showRemoveDialog({
    required BuildContext context,
    required VoidCallback onPressed,
    required String msg,
    required String title,
  }) {
    Dialogs.materialDialog(
      msg: msg,
      title: title,
      titleStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
      msgStyle: Theme.of(context).textTheme.headlineSmall!,
      msgAlign: TextAlign.center,
      color: Colors.white,
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      customView: MediaQuery.of(context).size.shortestSide > 600
          ? Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey)),
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.grey,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ปิด',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onPressed,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.red),
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ลบ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : SizedBox(),
      actions: MediaQuery.of(context).size.shortestSide > 600
          ? null
          : [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                text: 'ปิด',
                iconData: Icons.cancel_outlined,
                textStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                iconColor: Colors.grey,
              ),
              IconsButton(
                onPressed: onPressed,
                text: 'ลบ',
                iconData: Icons.delete,
                color: Colors.red,
                textStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                iconColor: Theme.of(context).primaryColor,
              ),
            ],
    );
  }

  showAlertCODConditionDialog({
    required BuildContext context,
    required Function onPressed,
    required Function onCancel,
    String? cancelText,
    String? okText,
  }) {
    Dialogs.materialDialog(
      barrierDismissible: false,
      msg:
          'เนื่องจากมาตรการ Dee-Delivery มีการปรับเปลี่ยนเงื่อนไขการส่งพัสดุแบบเก็บเงินปลายทาง (COD) ทางเราจึงจำเป็นต้องเพิ่มรายละเอียดสินค้าเพิ่มเติม',
      title: 'แจ้งเตือนจากระบบ',
      titleStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
      msgStyle: Theme.of(context).textTheme.headlineSmall!,
      msgAlign: TextAlign.center,
      color: Colors.white,
      lottieBuilder: Lottie.asset('assets/lottie/shipping.json'),
      context: context,
      customViewPosition: CustomViewPosition.BEFORE_ACTION,
      customView: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text('**เมื่อกดรับทราบ การแจ้งเตือนนี้จะไม่ขึ้นอีก**',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                )),
      ),
      actions: [
        IconsButton(
          onPressed: onPressed,
          text: okText ?? 'รับทราบ',
          color: Colors.blue,
          textStyle:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          iconColor: Theme.of(context).primaryColor,
        ),
        IconsOutlineButton(
          onPressed: onCancel,
          text: cancelText ?? 'ปิด',
          iconData: Icons.cancel_outlined,
          textStyle:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
          iconColor: Colors.grey,
        ),
      ],
    );
  }

  showAlertNormalDialog({
    required BuildContext context,
    required Function onPressed,
    String? titile,
    String? msg,
    String? cancelText,
    bool? barrierDismissible,
  }) {
    Dialogs.materialDialog(
      barrierDismissible: barrierDismissible ?? true,
      msg: msg ?? '',
      title: titile ?? 'แจ้งเตือนจากระบบ',
      titleStyle: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold),
      msgStyle: Theme.of(context).textTheme.headlineSmall!,
      msgAlign: TextAlign.center,
      color: Colors.white,
      lottieBuilder: Lottie.asset('assets/lottie/97670-tomato-error.json'),
      context: context,
      actions: [
        IconsOutlineButton(
          onPressed: onPressed,
          text: cancelText ?? 'ปิด',
          iconData: Icons.cancel_outlined,
          textStyle:
              Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
          iconColor: Colors.grey,
        ),
      ],
    );
  }
}
