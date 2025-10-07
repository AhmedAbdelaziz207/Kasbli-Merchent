import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/widgets/custom_text_field.dart';
import 'package:kasbli_merchant/features/product/widgets/product_and_sub_dropdown.dart';
import 'package:kasbli_merchant/features/product/widgets/product_variations.dart';

class AddProductFormSection extends StatelessWidget {
  const AddProductFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Prduct Description
        CustomTextField(
          controller: TextEditingController(),
          textInputAction: TextInputAction.next,
          labelText: 'Product Description',
          hintText: 'Type here',
          maxLines: 5,
          suffixIcon: const Icon(Icons.edit, color: AppColors.primaryColor),
        ),

        SizedBox(height: 16.h),

        Row(
          children: [
            // Prduct Name
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                    labelText: 'Starting Price ',
                hintText: '00.00 \$',
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Prduct Price
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                labelText: 'Final Price',
                hintText: '00.00 \$',
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        Row(
          children: [
            // Prduct Name
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                labelText: 'Discount Price ',
                hintText: '00.00 \$',
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Prduct Price
            Expanded(
              child: CustomTextField(
                controller: TextEditingController(),
                textInputAction: TextInputAction.next,
                labelText: 'Quantity',
                hintText: '0',
                keyboardType: TextInputType.number,
                suffixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // Prduct Category And Sub Category Drop Down
        ProductAndSubDropdown(),
        SizedBox(height: 21.h),

        // Product Variations
        ProductVariations(),
      ],
    );
  }
}
