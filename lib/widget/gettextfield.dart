import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectship_app/widget/fontsize.dart';

class GetTextField extends StatelessWidget {
  GetTextField(
      {Key? key,
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
      this.border})
      : super(key: key);
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
  final double? border;

  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black87, fontWeight: FontWeight.normal, fontSize: PlatformSize(context)),
      decoration: InputDecoration(
        hintText: title,
        hintStyle:
            Theme.of(context).textTheme.headline4!.copyWith(color: Colors.grey[500]!.withOpacity(.5), fontWeight: FontWeight.bold, fontSize: 14),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.all(2),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          icon: Icon(
            enableSuffixIcon != false ? sufIcon : null,
            color: Colors.grey[500],
          ),
          onPressed: visiblePress,
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue.shade200), borderRadius: BorderRadius.all(Radius.circular(4))),
        errorStyle: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.all(Radius.circular(4))),
        prefixIcon: enableIconPrefix != false
            ? Icon(
                preIcon,
                color: Colors.grey[500],
              )
            : null,
      ),
    );
  }
}
