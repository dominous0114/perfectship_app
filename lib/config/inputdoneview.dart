import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/fontsize.dart';

class InputDoneView extends StatelessWidget {
  const InputDoneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CupertinoColors.lightBackgroundGray,
        child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: CupertinoButton(
                padding:
                    const EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Text("เสร็จ",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: PlatformSize(context) * 1.2,
                        color: Colors.blue)),
              ),
            )));
  }
}
