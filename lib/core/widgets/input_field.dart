import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class InputField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final int height;
  final void Function(String?)? onSubmitted;
  final AutovalidateMode? autoValidateMode;
  final int? hintSize;

  const InputField({
    super.key,
    required this.label,
    this.autoValidateMode,
    this.hint,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
        this.height = 71,
    this.onSubmitted,
    this.hintSize,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = true;
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  listenFocus() {
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  bool shouldUsePrimaryColor = false;

  @override
  void initState() {
    shouldUsePrimaryColor = isFocused || widget.controller.text.isNotEmpty;
   
    listenFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 12.sp,
            color: isFocused ? AppColors.black : AppColors.blackLightActive,
          ),
        ),

        const SizedBox(height: 8),
        widget.maxLines == 1
            ? SizedBox(height: widget.height.h, child: buildInputField())
            : buildInputField(),
      ],
    );
  }

  buildInputField() {
    return TextFormField(
      autovalidateMode: widget.autoValidateMode,
      focusNode: focusNode,
      onTapOutside: (event) =>  focusNode.unfocus(),
      controller: widget.controller,
      obscureText: widget.isPassword && _obscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      maxLines: widget.maxLines,
      minLines: widget.maxLines,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      onSaved: widget.onSubmitted,
      onFieldSubmitted: (value) {
        if (value.isNotEmpty) {
          setState(() {
            shouldUsePrimaryColor = true;
          });
        }
      },
      style: TextStyle(
        color: isFocused ? AppColors.primaryColor : AppColors.textSecondary,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefix,
        hintStyle: TextStyle(
          fontSize: widget.hintSize?.sp ?? 12.sp,
          color: AppColors.textLightGrey,
        ),
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color:
                        isFocused
                            ? AppColors.primaryColor
                            : AppColors.blackLightActive,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : widget.suffix,
      ),
    );
  }
}
