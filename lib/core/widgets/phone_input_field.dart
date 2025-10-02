import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';

class CustomIntlPhoneField extends StatefulWidget {
  const CustomIntlPhoneField({
    super.key,
    this.validator,
    this.controller,
    this.onCountryChanged,
    this.onSubmit,
    this.label,
    this.height = 78,
  });

  final FutureOr<String?> Function(PhoneNumber?)? validator;
  final void Function(Country)? onCountryChanged;
  final Function(String)? onSubmit;
  final TextEditingController? controller;
  final String? label;
  final int height;

  @override
  State<CustomIntlPhoneField> createState() => _CustomIntlPhoneFieldState();
}

class _CustomIntlPhoneFieldState extends State<CustomIntlPhoneField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  listenFocus() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    listenFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
            color: isFocused ? AppColors.black : AppColors.blackLightActive,
          ),
        ),
        const SizedBox(height: 8),

        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: 'EG',
          showCountryFlag: false,
          showDropdownIcon: true,
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) => SizedBox(),
          autovalidateMode: AutovalidateMode.disabled,
          validator: widget.validator,
          focusNode: _focusNode,
          onCountryChanged: widget.onCountryChanged,
    
          dropdownIconPosition: IconPosition.trailing,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: AppColors.blackLight,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(
                color: AppColors.primaryColor,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.0),
              borderSide: BorderSide(
                color: AppColors.primaryColor.withOpacity(0.5),
                width: 1.0,
              ),
            ),

            hintText: '1234567890',
            hintStyle: TextStyle(
              color: AppColors.textHint.withOpacity(.5),
              fontSize: 12.0.sp,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            filled: false,
          ),

          style: TextStyle(
            color:
                isFocused ? AppColors.primaryColor : AppColors.blackLightActive,
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),

          dropdownTextStyle: TextStyle(
            color:
                isFocused ? AppColors.primaryColor : AppColors.blackLightActive,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),

          onSubmitted: widget.onSubmit,
        ),
      ],
    );
  }
}

