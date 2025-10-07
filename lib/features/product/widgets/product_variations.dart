import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kasbli_merchant/core/theme/app_colors.dart';
import 'package:kasbli_merchant/core/widgets/custom_text_field.dart';
import 'package:kasbli_merchant/core/widgets/primary_button.dart';
import 'package:kasbli_merchant/features/product/logic/products_cubit.dart';
import 'package:kasbli_merchant/features/product/logic/products_states.dart';

class ProductVariations extends StatefulWidget {
  const ProductVariations({super.key});

  @override
  State<ProductVariations> createState() => _ProductVariationsState();
}

class _ProductVariationsState extends State<ProductVariations>
    with TickerProviderStateMixin {
  List<TextEditingController> _colorsControllers = [];
  List<TextEditingController> _colorQuantityControllers = [];
  List<TextEditingController> _sizesControllers = [];
  List<TextEditingController> _sizeQuantityControllers = [];

  late AnimationController _variationsController;
  late Animation<double> _variationsAnimation;
  late AnimationController _sizesController;
  late Animation<double> _sizesAnimation;

  @override
  void initState() {
    super.initState();
    _variationsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _variationsAnimation = CurvedAnimation(
      parent: _variationsController,
      curve: Curves.easeInOut,
    );

    _sizesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sizesAnimation = CurvedAnimation(
      parent: _sizesController,
      curve: Curves.easeInOut,
    );

    // Check initial state from cubit and set controller values
    final cubit = context.read<ProductsCubit>();
    if (cubit.hasVariations) {
      _variationsController.forward();
    }
    if (cubit.hasSizes) {
      _sizesController.forward();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = context.read<ProductsCubit>();
    _colorsControllers =
        cubit.colors
            .map((c) => TextEditingController(text: c.colorName))
            .toList();
    _colorQuantityControllers =
        cubit.colors
            .map(
              (c) => TextEditingController(text: c.quantity?.toString() ?? ''),
            )
            .toList();
    _sizesControllers =
        cubit.productSizes
            .map((c) => TextEditingController(text: c.sizeName))
            .toList();
    _sizeQuantityControllers =
        cubit.productSizes
            .map(
              (c) => TextEditingController(text: c.quantity?.toString() ?? ''),
            )
            .toList();
  }

  addNewColorController() {
    _colorsControllers.add(TextEditingController());
    _colorQuantityControllers.add(TextEditingController());
  }

  removeColorController(int index) {
    _colorsControllers.removeAt(index);
    _colorQuantityControllers.removeAt(index);
  }

  addNewSizeController() {
    _sizesControllers.add(TextEditingController());
    _sizeQuantityControllers.add(TextEditingController());
  }

  removeSizeController(int index) {
    _sizesControllers.removeAt(index);
    _sizeQuantityControllers.removeAt(index);
  }

  @override
  void dispose() {
    _variationsController.dispose();
    _sizesController.dispose();
    for (var controller in _colorsControllers) {
      controller.dispose();
    }
    for (var controller in _colorQuantityControllers) {
      controller.dispose();
    }
    for (var controller in _sizesControllers) {
      controller.dispose();
    }
    for (var controller in _sizeQuantityControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ToggleVariationsFlagState) {
          if (cubit.hasVariations) {
            _variationsController.forward();
          } else {
            _variationsController.reverse();
          }
          if (cubit.hasSizes) {
            _sizesController.forward();
          } else {
            _sizesController.reverse();
          }
        }
      },
      child: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                "Product Variations",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Checkbox(
                    value: cubit.hasVariations,
                    fillColor: WidgetStateProperty.all(AppColors.white),
                    checkColor: AppColors.primaryColor,
                    onChanged: (value) {
                      cubit.toggleHasVariations(value!);
                    },
                  ),
                  Expanded(
                    child: Text(
                      "This product has variations (e.g. color, size)",
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: FadeTransition(
                  opacity: _variationsAnimation,
                  child:
                      cubit.hasVariations
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              // Colors List
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit.colors.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextField(
                                          controller: _colorsControllers[index],
                                          onChanged: (value) {
                                            cubit.updateColor(
                                              index,
                                              name: value,
                                            );
                                          },
                                          labelText: 'Color Name',
                                          hintText: 'Type here',
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        flex: 1,
                                        child: CustomTextField(
                                          controller:
                                              _colorQuantityControllers[index],
                                          onChanged: (value) {
                                            cubit.updateColor(
                                              index,
                                              quantity:
                                                  int.tryParse(value) ?? 0,
                                            );
                                          },
                                          labelText: 'Quantity',
                                          hintText: '0',
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      GestureDetector(
                                        onTap: () {
                                          showColorPickerDialog(context, (
                                            color,
                                          ) {
                                            cubit.updateColor(
                                              index,
                                              code:
                                                  '0x${color.value.toRadixString(16)}',
                                            );
                                          });
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              cubit.colors[index].colorCode !=
                                                      null
                                                  ? Color(
                                                    int.parse(
                                                      cubit
                                                          .colors[index]
                                                          .colorCode!,
                                                    ),
                                                  )
                                                  : Colors.grey,
                                          radius: 15.r,
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      if (index == cubit.colors.length - 1)
                                        IconButton(
                                          onPressed: () {
                                            cubit.addNewColorField();
                                            addNewColorController();
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                      else
                                        IconButton(
                                          onPressed: () {
                                            cubit.removeColor(index);
                                            removeColorController(index);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                                separatorBuilder:
                                    (context, index) => SizedBox(height: 12.h),
                              ),
                              SizedBox(height: 16.h),
                              Row(
                                children: [
                                  Checkbox(
                                    value: cubit.hasSizes,
                                    fillColor: WidgetStateProperty.all(
                                      AppColors.white,
                                    ),
                                    checkColor: AppColors.primaryColor,

                                    onChanged: (value) {
                                      cubit.toggleHasSizes(value!);
                                    },
                                  ),
                                  const Text("This product has sizes"),
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                child: FadeTransition(
                                  opacity: _sizesAnimation,
                                  child:
                                      cubit.hasSizes
                                          ? Padding(
                                            padding: EdgeInsets.only(top: 16.h),
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  cubit.productSizes.length,
                                              itemBuilder:
                                                  (context, index) => Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: CustomTextField(
                                                          controller:
                                                              _sizesControllers[index],
                                                          onChanged: (value) {
                                                            cubit.updateSize(
                                                              index,
                                                              name: value,
                                                            );
                                                          },
                                                          labelText:
                                                              'Size Name',
                                                          hintText: 'Type here',
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      Expanded(
                                                        flex: 1,
                                                        child: CustomTextField(
                                                          controller:
                                                              _sizeQuantityControllers[index],
                                                          onChanged: (value) {
                                                            cubit.updateSize(
                                                              index,
                                                              quantity:
                                                                  int.tryParse(
                                                                    value,
                                                                  ) ??
                                                                  0,
                                                            );
                                                          },
                                                          labelText: 'Quantity',
                                                          hintText: '0',
                                                        ),
                                                      ),
                                                      SizedBox(width: 8.w),
                                                      if (index ==
                                                          cubit
                                                                  .productSizes
                                                                  .length -
                                                              1)
                                                        IconButton(
                                                          onPressed: () {
                                                            cubit
                                                                .addNewSizeField();
                                                            addNewSizeController();
                                                          },
                                                          icon: const Icon(
                                                            Icons.add,
                                                            color:
                                                                AppColors
                                                                    .primaryColor,
                                                          ),
                                                        )
                                                      else
                                                        IconButton(
                                                          onPressed: () {
                                                            cubit.removeSize(
                                                              index,
                                                            );
                                                            removeSizeController(
                                                              index,
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.remove,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 12.h),
                                            ),
                                          )
                                          : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          )
                          : const SizedBox.shrink(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

showColorPickerDialog(BuildContext context, Function(Color) onColorSelected) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Colors.red,
              hexInputBar: true,

              onColorChanged: onColorSelected,
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
