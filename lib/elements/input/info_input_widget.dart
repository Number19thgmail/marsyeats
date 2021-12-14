import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base/base_input_widget.dart';

class InfoInputWidget extends BaseInputWidget {
  InfoInputWidget({
    TextEditingController? controller,
    String? hintText,
    String? labelText,
    required ValueChanged<String> onChanged,
    List<TextInputFormatter>? inputFormatters,
    VoidCallback? onTap,
    bool isAutoFocus = false,
    bool isEnabled = true,
    bool readOnly = false,
  }) : super(
          onTap: onTap,
          readOnly: readOnly,
          controller: controller,
          inputFormatters: inputFormatters,
          hintText: hintText,
          labelText: labelText,
          isAutoFocus: isAutoFocus,
          onChanged: onChanged,
          isEnabled: isEnabled,
        );
}
