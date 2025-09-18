// Widget for Date of Birth input field
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';

import '../../../core/theme/app_colors.dart';

typedef DateValidatorFunction = String? Function(DateTime?);

class DateOfBirthInput extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final DateValidatorFunction? validator;
  final DateTime? initialDate;

  const DateOfBirthInput({
    super.key,
    required this.onDateSelected,
    this.validator,
    this.initialDate,
  });

  @override
  State<DateOfBirthInput> createState() => _DateOfBirthInputState();
}

class _DateOfBirthInputState extends State<DateOfBirthInput> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  DateTime? _selectedDate;

  void _listenFocus() {
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _listenFocus();
    _selectedDate = widget.initialDate;
    if (_selectedDate != null) {
      _dateOfBirthController.text = DateFormat('dd/MM/yy').format(_selectedDate!);
    }
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();
    _listenFocus();
    super.dispose();
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryNormal, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryNormal, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateOfBirthController.text = DateFormat('dd/MM/yy').format(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: _selectedDate,
      validator: widget.validator,
      builder: (formState) {
        final hasError = formState.hasError;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppKeys.dateOfBirth.tr(),
              style: TextStyle(
                color: hasError
                    ? Colors.red
                    : (isFocused
                        ? AppColors.primaryColor
                        : AppColors.blackLightActive),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            TextFormField(
              controller: _dateOfBirthController,
              focusNode: _focusNode,
              readOnly: true,
              onTap: () async {
                await _selectDate(context);
                formState.didChange(_selectedDate);
              },
              decoration: _commonInputDecoration(
                hintText: '12/12/91',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    color: hasError
                        ? Colors.red
                        : (isFocused
                            ? AppColors.primaryColor
                            : AppColors.textSecondary),
                  ),
                  onPressed: () async {
                    await _selectDate(context);
                    formState.didChange(_selectedDate);
                  },
                ),
              ).copyWith(
                errorText: formState.errorText,
              ),
              style: const TextStyle(color: Colors.black87, fontSize: 16.0),
            ),
          ],
        );
      },
    );
  }
}

InputDecoration _commonInputDecoration({String? hintText, Widget? suffixIcon}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: AppColors.textLightGrey, fontSize: 16.0),
    suffixIcon: suffixIcon,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: const BorderSide(
        color: AppColors.textPrimary, // Teal border
        width: 1.5,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.0),
      borderSide: const BorderSide(color: AppColors.blackLight, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(7.0),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2.0),
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
    filled: false,
  );
}

