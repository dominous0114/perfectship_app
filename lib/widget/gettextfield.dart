import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetTextField extends StatelessWidget {
  GetTextField({
    Key? key,
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
    this.suffixText,
    this.textAlign,
    this.border,
    this.prefixIconColor,
    this.autoFocus = false,
    this.maxLines = 1,
  }) : super(key: key);
  final String? Function(String?)? validator;
  final String? title;
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
  final String? suffixText;
  final bool? enabled;
  final TextAlign? textAlign;
  final Color? prefixIconColor;
  final bool autoFocus;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
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
      textAlign: textAlign ?? TextAlign.start,
      textInputAction: TextInputAction.done, // Set textInputAction to done
      maxLines: maxLines, // Restrict input to a single line
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        counterStyle: Theme.of(context).textTheme.titleLarge,
        suffixIcon: enableSuffixIcon == false
            ? null
            : sufIcon == null
                ? null
                : GestureDetector(onTap: visiblePress, child: Icon(sufIcon)),
        suffixText: suffixText == null ? null : suffixText,
        hintText: '  ${title ?? ''}',
        hintStyle: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: Theme.of(context).focusColor.withOpacity(.3), fontWeight: FontWeight.bold),
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 7),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.7, color: Colors.grey), //<-- SEE HERE
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue.shade200),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        errorStyle: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: enableIconPrefix != false
            ? Icon(
                preIcon,
                color: prefixIconColor == null ? Colors.grey[500] : prefixIconColor,
              )
            : null,
      ),
    );
  }
}
