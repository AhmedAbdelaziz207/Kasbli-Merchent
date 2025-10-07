import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasbli_merchant/core/utils/file_picker_util.dart';
import 'package:kasbli_merchant/features/product/logic/products_states.dart';
import 'package:kasbli_merchant/features/product/model/product_color_model.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  File? _mainImage;
  get mainImage => _mainImage;
  final List<File?> _productImages = [];
  get productImages => _productImages;

  final List<ProductColorModel> _colors = [
    ProductColorModel(colorName: "Transparent",),
  ];
  List<ProductColorModel> get colors => _colors;

  void addNewColorField() {
    _colors.add(ProductColorModel());
    emit(ChangeColorsState());
  }

  void removeColor(int index) {
    if (_colors.length > 1) {
      _colors.removeAt(index);
      emit(ChangeColorsState());
    }
  }

  void updateColor(int index, {String? name, String? code, int? quantity}) {
    final currentColor = _colors[index];
    _colors[index] = ProductColorModel(
      colorName: name ?? currentColor.colorName,
      colorCode: code ?? currentColor.colorCode,
      quantity: quantity ?? currentColor.quantity,
    );
    emit(ChangeColorsState());
  }

  // Product Sizes
  final List<ProductSizeModel> _productSizes = [
    ProductSizeModel(sizeName: "S"),
  ]; 

  List<ProductSizeModel> get productSizes => _productSizes;

  void addNewSizeField() {
    _productSizes.add(ProductSizeModel());
    emit(ChangeProductSizesState());
  }

  void removeSize(int index) {
    if (_productSizes.length > 1) {
      _productSizes.removeAt(index);
      emit(ChangeProductSizesState());
    }
  }

  void updateSize(int index, {String? name, int? quantity}) {
    final currentSize = _productSizes[index];
    _productSizes[index] = ProductSizeModel(
      sizeName: name ?? currentSize.sizeName,
      quantity: quantity ?? currentSize.quantity,
    );
    emit(ChangeProductSizesState());
  }

  bool _hasVariations = false;
  bool get hasVariations => _hasVariations;

  bool _hasSizes = false;
  bool get hasSizes => _hasSizes;

  void toggleHasVariations(bool value) {
    _hasVariations = value;
    if (!value) {
      _hasSizes = false; // Also hide sizes if variations are hidden
    }
    emit(ToggleVariationsFlagState());
  }

  void toggleHasSizes(bool value) {
    _hasSizes = value;
    emit(ToggleVariationsFlagState());
  }



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
