import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/widgets/app_bar_widget.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/product/widgets/add_product_form_section.dart';
import 'package:kasbli_merchant/features/product/widgets/add_product_media_section.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Add Product',
        showBackButton: true,
        backButtonBackgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 16.0.h),
          child: Column(
            children: [
              // Media Section
              AddProductMediaSection(),

              SizedBox(height: 16.h),
              // Product Details Section
              AddProductFormSection(),

              // Add Button
              SizedBox(height: 30.0.h),
              PrimaryButton(onPressed: () {}, text: 'Add Product'),
            ],
          ),
        ),
      ),
    );
  }
}
