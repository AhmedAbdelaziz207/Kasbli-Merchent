import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/widgets/custom_text_field.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';

class ProductVariations extends StatelessWidget {
  const ProductVariations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.h,
      children: [
        Text(
          "Product Colors",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),

        SizedBox(height: 16.h),

        // Pick Colors
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(),
                labelText: 'Color Name',
                hintText: 'Type here',
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            IconButton(
              onPressed: () {
                shoColorPickerDialog(context);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

shoColorPickerDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.red,
              hexInputBar: true,

              onColorChanged: (color) {},
            ),
          ),
          actions: <Widget>[
            PrimaryButton(
              text: "Got it",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
  );
}
