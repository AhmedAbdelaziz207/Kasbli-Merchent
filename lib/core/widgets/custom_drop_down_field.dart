import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class CustomDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final Function(String?)? onSelected;
  final String? Function(String?)? validator;
  final String? initialValue;
  // Optional: customize how each item is displayed (e.g., localization)
  final String Function(String value)? displayBuilder;

  const CustomDropdownField({
    super.key,
    required this.hintText,
    required this.items,
    this.onSelected,
    this.validator,
    this.initialValue,
    this.displayBuilder,
  });

  @override
  State<CustomDropdownField> createState() => _CustomDropdownFieldState();
}

class _CustomDropdownFieldState extends State<CustomDropdownField> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CustomDropdownField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8.w),
                border: Border.all(
                  color: state.hasError ? Colors.red : AppColors.grey,
                  width: 1.w,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedValue,
                  hint: Text(
                    widget.hintText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.grey),
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 28.sp,
                    color: AppColors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                    state.didChange(newValue); // important for validation
                    widget.onSelected?.call(newValue);
                  },
                  items: widget.items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        widget.displayBuilder?.call(value) ?? value,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppColors.secondaryColor),
                      ),
                    );
                  }).toList(),
                ),
              ),
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
