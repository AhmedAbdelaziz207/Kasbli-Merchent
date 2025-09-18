class ProductsResponse {
  ProductsResponse();
  factory ProductsResponse.fromJson(Map<String, dynamic> json) => ProductsResponse();
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class ProductModel {
  ProductModel();
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel();
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class OfferModel {
  final int id;
  final int discount;
  OfferModel({required this.id, required this.discount});
}
