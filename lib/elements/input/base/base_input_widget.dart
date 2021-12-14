import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseInputWidget extends TextFormField {
  BaseInputWidget({
    TextEditingController? controller,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? labelText,
    String? hintText,
    String? prefix,
    IconData? icon,
    VoidCallback? onIconPressed,
    VoidCallback? onTap,
    bool isAutoFocus = false,
    bool isEnabled = true,
    bool obscureText = false,
    bool readOnly = false,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
    String? Function(String? value)? validator,
    double? labelSize,
    Color? labelColor,
    String? initialValue,
    double? hintSize,
    Color? hintColor,
    double? inputTextSize,
    FontWeight? inputFontWeight,
    Color? inputTextColor,
    double? inputTextHeight,
  }) : super(
          onTap: onTap,
          readOnly: readOnly,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            labelText: labelText,
            hintText: hintText,
            contentPadding: const EdgeInsets.fromLTRB(
              16,
              12,
              16,
              12,
            ),
            suffixIcon: icon == null
                ? null
                : IconButton(
                    icon: Icon(
                      icon,
                      size: 24,
                    ),
                    color: borderEditField,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: onIconPressed,
                  ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderEditField,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorRedActive,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: borderEditField.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: errorRedActive),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8,
                ),
              ),
            ),
          ),
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          inputFormatters: inputFormatters,
          autofocus: isAutoFocus,
          enabled: isEnabled,
          cursorColor: borderEditField,
          obscureText: obscureText,
          onChanged: onChanged,
          initialValue: initialValue,
        );
}

Color borderEditField = Colors.blue;
Color errorRedActive = Color(0xFFFF0000);