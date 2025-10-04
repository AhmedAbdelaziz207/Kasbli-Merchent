import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/utils/file_picker_util.dart';
import 'package:kasbli_merchant/features/product/logic/products_states.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  File? _mainImage;
  List<File?> _productImages = [];

  get mainImage => _mainImage;
  get productImages => _productImages;
  void pickMainImage() async {
    final image = await FilePickerUtil.instance.pick(PickType.image);
    if (image != null) {
      emit(ChangeMainImageState());
      _mainImage = image;
    }
  }

  void pickProductImage() async {
    final image = await FilePickerUtil.instance.pick(PickType.image);
    if (image != null) {
      emit(ChangeProductImageState());
      _productImages.add(image);
    }

  }

    void removeProductImage(int index) {
      _productImages.removeAt(index);
      emit(ChangeProductImageState());
    }

    void removeMainImage() {
      _mainImage = null;
      emit(ChangeMainImageState());
    }

  
}
