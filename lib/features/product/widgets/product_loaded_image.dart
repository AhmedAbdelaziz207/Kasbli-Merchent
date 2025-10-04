import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kasbli_merchant/core/widgets/custom_image_loader.dart';

class ProductLoadedImage extends StatelessWidget {
  const ProductLoadedImage({
    super.key,
    required this.imagePath,
    required this.isNetworkImage,
    required this.isImageFile,
    required this.width,
    required this.height,
    required this.onDelete,
  });
  
  final String imagePath;
  final bool isNetworkImage;
  final bool isImageFile;
  final double width;
  final double height;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.black12),
      ),
      child: Stack(
        children: [
          InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: CustomImageLoader(
                      imagePath: imagePath,
                      isNetworkImage: isNetworkImage,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                      isImageFile: isImageFile,
                    ),
                  );
                },
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomImageLoader(
                imagePath: imagePath,
                isNetworkImage: isNetworkImage,
                fit: BoxFit.cover,
                width: width,
                height: height,
                isImageFile: isImageFile,
              ),
            ),
          ),

          Positioned(
            top: 2.h,
            right: 0.w,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
