import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/widgets/custom_drop_down_field.dart';
import 'package:kasbli_merchant/core/widgets/custom_snackbar.dart';
import 'package:kasbli_merchant/features/categories/logic/categories_cubit.dart';
import 'package:kasbli_merchant/features/categories/logic/categories_state.dart';
import 'package:kasbli_merchant/features/categories/model/category_model.dart';

class ProductAndSubDropdown extends StatefulWidget {
  const ProductAndSubDropdown({super.key});

  @override
  State<ProductAndSubDropdown> createState() => _ProductAndSubDropdownState();
}

class _ProductAndSubDropdownState extends State<ProductAndSubDropdown> {
  CategoryModel? selectedCategory;
  Subcategory? selectedSubcategory;
  List<Subcategory> availableSubcategories = [];

  void _onCategorySelected(String? categoryName, List<CategoryModel> categories) {
    if (categoryName == null) return;
    
    final category = categories.firstWhere((cat) => cat.name == categoryName);
    setState(() {
      selectedCategory = category;
      selectedSubcategory = null; // Reset subcategory when category changes
      availableSubcategories = category.subcategories ?? [];
    });
    
    print("Selected Category ID: ${category.id}");
    print("Selected Category Name: ${category.name}");
  }

  void _onSubcategorySelected(String? subcategoryName) {
    if (subcategoryName == null || availableSubcategories.isEmpty) return;
    
    final subcategory = availableSubcategories.firstWhere((sub) => sub.name == subcategoryName);
    setState(() {
      selectedSubcategory = subcategory;
    });
    
    print("Selected Subcategory ID: ${subcategory.id}");
    print("Selected Subcategory Name: ${subcategory.name}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen:
          (previous, current) =>
              current is CategoriesLoaded ||
              current is CategoriesLoading ||
              current is CategoriesFailure,
      builder: (context, state) {
        if (state is CategoriesFailure) {
          CustomSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }

        final List<CategoryModel> categories =
            state is CategoriesLoaded ? state.categories : [];
        
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomDropdownField(
                    hintText: "Category",
                    value: selectedCategory?.name,
                    onSelected: (value) => _onCategorySelected(value, categories),
                    items: categories.map((e) => e.name ?? '').toList(),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sub-Category",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomDropdownField(
                    hintText: "Sub Category",
                    value: selectedSubcategory?.name,
                    onSelected: _onSubcategorySelected,
                    items: availableSubcategories.map((e) => e.name ?? '').toList(),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
