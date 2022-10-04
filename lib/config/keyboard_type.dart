import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../widget/fontsize.dart';

TextInputType textInputNum =
    Platform.isAndroid ? TextInputType.number : TextInputType.number;

TextInputType textInputPhone =
    Platform.isAndroid ? TextInputType.phone : TextInputType.phone;

KeyboardActionsConfig buildConfig(BuildContext context, FocusNode focusNode) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    keyboardBarColor: Colors.grey[200],
    nextFocus: true,
    actions: [
      KeyboardActionsItem(
        focusNode: focusNode,
        toolbarButtons: [
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Done',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: PlatformSize(context)),
                  )),
            );
          }
        ],
      ),
    ],
  );
}
