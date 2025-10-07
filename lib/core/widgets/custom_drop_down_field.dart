import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomDropdownField extends StatefulWidget {

  final String hintText;
  final List<String> items;
  final Function(String?)? onSelected;
  final String? Function(String?)? validator;
  final String? initialValue;
  final String? value;
  // Optional: Customize how each item is displayed (e.g., Localization)
  final String Function(String value)? displayBuilder;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.onSelected,
    this.validator,
    this.initialValue,
    this.value,
    this.displayBuilder,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              isExpanded: true,
              value: widget.value,
              hint: Text(
                widget.hintText,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey,
                  fontSize: 12.sp,
                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down_rounded,
                size: 28.sp,
                color: AppColors.primaryColor,
              ),
              onChanged: (String? newValue) {
                setState(() {
                });
                state.didChange(newValue); // important for validation
                widget.onSelected?.call(newValue);
              },
              items:
                  widget.items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,

                      child: Text(
                        widget.displayBuilder?.call(value) ?? value,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.secondaryColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }).toList(),
            ),

            if (state.hasError)
              Padding(
                padding: EdgeInsets.only(top: 4.h, left: 4.w),
                child: Text(
                  state.errorText!,
                  style: TextStyle(color: Colors.red, fontSize: 12.sp),
                ),
              ),
          ],
        );
      },
    );
  }
}
