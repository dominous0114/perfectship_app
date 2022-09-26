import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectship_app/widget/fontsize.dart';

class GetTextField extends StatelessWidget {
  GetTextField({
    Key? key,
    this.minLine,
    this.maxLine,
    this.title,
    this.preIcon,
    this.sufIcon,
    this.textInputType,
    this.enableSuffixIcon,
    this.validator,
    this.controller,
    this.visible = false,
    this.visiblePress,
    this.onChanged,
    this.maxLength,
    this.onTap,
    this.textInputAction,
    this.focusNode,
    this.initialValue,
    this.onSaved,
    this.enableIconPrefix = false,
    this.labelText,
    this.enabled = true,
  }) : super(key: key);
  final String? Function(String?)? validator;
  String? title;
  final bool? enableSuffixIcon;
  final TextInputType? textInputType;
  final IconData? preIcon;
  final IconData? sufIcon;
  final TextEditingController? controller;
  final bool visible;
  final Function()? visiblePress;
  final Function(String)? onChanged;
  final int? maxLength;
  final Function()? onTap;
  final Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? initialValue;
  final bool? enableIconPrefix;
  final String? labelText;
  final int? minLine;
  final int? maxLine;
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLine,
      maxLines: maxLine,
      // decoration: InputDecoration(
      //   isDense: true,
      //   contentPadding: EdgeInsets.all(2),
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(8))),
      //   focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey.shade500),
      //       borderRadius: BorderRadius.all(Radius.circular(8))),
      //   // enabledBorder: OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(8))),
      //   // errorBorder: OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(8))),
      //   // disabledBorder: OutlineInputBorder(
      //   //     borderRadius: BorderRadius.all(Radius.circular(8))),
      // ),
      autofocus: false,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      obscureText: visible,
      keyboardType: textInputType,
      validator: validator,
      focusNode: focusNode,
      onTap: onTap,
      onSaved: onSaved,
      enabled: enabled,
      textInputAction: textInputAction,
      style: Theme.of(context).textTheme.headline4!.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.normal,
          fontSize: PlatformSize(context)),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
            color: Colors.grey[500]!.withOpacity(.5),
            fontWeight: FontWeight.bold,
            fontSize: PlatformSize(context)),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.all(2),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
        ),
        suffixIcon: IconButton(
          icon: Icon(
            enableSuffixIcon != false ? sufIcon : null,
            color: Colors.grey[500],
          ),
          onPressed: visiblePress,
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade200),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        errorStyle: Theme.of(context).textTheme.headline4!.copyWith(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
        prefixIcon: enableIconPrefix != false
            ? Icon(
                preIcon,
                color: Colors.grey[500],
              )
            : null,
      ),

      // decoration: InputDecoration(
      //   border: OutlineInputBorder(
      //       borderRadius: BorderRadius.all(Radius.circular(8))),
      //   focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.grey.shade500),
      //       borderRadius: BorderRadius.all(Radius.circular(8))),

      //   // errorStyle: Theme.of(context).textTheme.headline4!.copyWith(
      //   //     color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
      //   // prefixIcon: enableIconPrefix != false
      //   //     ? Icon(
      //   //         preIcon,
      //   //         color: Colors.grey[500],
      //   //       )
      //   //     : null,
      //   // contentPadding: EdgeInsets.all(0),
      //   // hintText: title,
      //   // labelText: labelText,
      //   // labelStyle: Theme.of(context).textTheme.headline4!.copyWith(
      //   //     // color: focusNode.hasFocus || controller!.text.isNotEmpty ? Colors.blue : Colors.grey[500]!.withOpacity(.5),
      //   //     fontWeight: FontWeight.bold,
      //   //     fontSize: 16),

      //   // hintStyle: Theme.of(context).textTheme.headline4!.copyWith(
      //   //     color: Colors.grey[500]!.withOpacity(.5),
      //   //     fontWeight: FontWeight.bold,
      //   //     fontSize: 16),
      // suffixIcon: IconButton(
      //   icon: Icon(
      //     enableSuffixIcon != false ? sufIcon : null,
      //     color: Colors.grey[500],
      //   ),
      //   onPressed: visiblePress,
      // ),
      //   // enabledBorder: UnderlineInputBorder(
      //   //   borderSide: BorderSide(color: Colors.grey[500]!.withOpacity(.3)),
      //   // ),
      //   // focusedBorder: UnderlineInputBorder(
      //   //   borderSide: BorderSide(color: Colors.grey[800]!.withOpacity(.5)),
      //   // ),
      //   //border: OutlineInputBorder(),
      //   // border: InputBorder.none
      // ),
    );
  }
}
