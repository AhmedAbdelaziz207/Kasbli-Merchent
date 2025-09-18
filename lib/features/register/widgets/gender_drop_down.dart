import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/utils/app_keys.dart';

typedef ValidatorFunction = String? Function(String?);

class GenderDropdownInput extends StatefulWidget {
  final Function(String?) onChanged;
  final ValidatorFunction? validator;
  final String? initialValue;

  const GenderDropdownInput({
    super.key,
    required this.onChanged,
    this.validator,
    this.initialValue,
  });

  @override
  State<GenderDropdownInput> createState() => _GenderDropdownInputState();
}

class _GenderDropdownInputState extends State<GenderDropdownInput> {
  String? _selectedGender;
  final List<String> _genders = [AppKeys.male.tr(), AppKeys.female.tr()];
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialValue;
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
      if (!isFocused) {
        _validate(_selectedGender);
      }
    });
  }

  void _validate(String? value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  void _onChanged(String? value) {
    setState(() {
      _selectedGender = value;
      _errorText = null;
    });
    widget.onChanged(value);
    _validate(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppKeys.gender.tr(),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          focusNode: _focusNode,
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _errorText != null
                    ? AppColors.error
                    : isFocused
                        ? AppColors.primaryNormal
                        : AppColors.lightBorder,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _errorText != null
                    ? AppColors.error
                    : isFocused
                        ? AppColors.primaryNormal
                        : AppColors.lightBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _errorText != null ? AppColors.error : AppColors.primaryNormal,
                width: 1.5,
              ),
            ),
            errorText: _errorText,
            errorStyle: const TextStyle(
              color: AppColors.error,
              fontSize: 12.0,
            ),
            hintText: AppKeys.selectGender.tr(),
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.5),
              fontSize: 14.0,
            ),
          ),
          items: _genders.map((String gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(
                gender,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14.0,
                ),
              ),
            );
          }).toList(),
          onChanged: _onChanged,
          validator: widget.validator,
        ),
      ],
    );
  }
}

