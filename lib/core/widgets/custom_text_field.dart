import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autoValidateMode;
  final bool autofocus;
  final bool constrainHeight;
  final double? height;
  final List<String>? autofillHints;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.autoValidateMode,
    this.autofocus = false,
    this.constrainHeight = false,
    this.height = 60,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8.h),
        ],
        SizedBox(
          height: constrainHeight ? height : null,
          child: TextFormField(
            controller: controller,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            obscureText: obscureText,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            textCapitalization: textCapitalization,
            autovalidateMode: autoValidateMode,
            autofocus: autofocus,
            style: TextStyle(fontSize: 12.sp),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.grey, // Adjust if needed
                fontSize: 16.0,
              ),
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: AppColors.greyLightActive.withOpacity(.3),
              // Light gray background
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 0.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30), // Pill shape
                borderSide: BorderSide.none, // No border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
