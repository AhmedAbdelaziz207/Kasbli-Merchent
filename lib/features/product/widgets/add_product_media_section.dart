import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/features/product/logic/products_cubit.dart';
import 'package:kasbli_merchant/features/product/logic/products_states.dart';
import 'package:kasbli_merchant/features/product/widgets/main_image_empty_card.dart';
import 'package:kasbli_merchant/features/product/widgets/product_loaded_image.dart';
import 'package:kasbli_merchant/features/product/widgets/thumb_box.dart';

class AddProductMediaSection extends StatelessWidget {
  const AddProductMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productsCubit = context.read<ProductsCubit>();

    return BlocBuilder<ProductsCubit, ProductsState>(
      buildWhen:
          (previous, current) =>
              current is ChangeMainImageState ||
              current is ChangeProductImageState,
      builder: (context, state) {
        return Container(
          height: 300.h,
          padding: EdgeInsets.all(12.r),
          color: Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 88.w,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    ...productsCubit.productImages.map(
                      (image) => ProductLoadedImage(
                        imagePath: image!.path,
                        isNetworkImage: false,
                        isImageFile: true,
                        width: 88.w,
                        height: 88.h,
                        onDelete: () {
                          productsCubit.removeProductImage(
                            productsCubit.productImages.indexOf(image),
                          );
                        },
                      ),
                    ),
                    ThumbBox(
                      onTap: () {
                        productsCubit.pickProductImage();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              if (productsCubit.mainImage == null)
                Expanded(
                  child: MainImageEmptyCard(
                    onChange: () {
                      productsCubit.pickMainImage();
                    },
                    iconColor: theme.colorScheme.onSurface.withOpacity(0.4),
                    buttonColor: theme.colorScheme.primary,
                  ),
                ),

              if (productsCubit.mainImage != null)
                Expanded(
                  child: ProductLoadedImage(
                    imagePath: productsCubit.mainImage!.path,
                    isNetworkImage: false,
                    isImageFile: true,
                    width: double.infinity,
                    height: double.infinity,
                    onDelete: () {
                      productsCubit.removeMainImage();
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
