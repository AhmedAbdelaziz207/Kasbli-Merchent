class ProductColorModel {
  final String? colorName;
  final String? colorCode;
  final int? quantity;

  ProductColorModel({ this.colorName, this.colorCode, this.quantity});

  // from Json
  factory ProductColorModel.fromJson(Map<String, dynamic> json) {
    return ProductColorModel(
      colorName: json['colorName'],
      colorCode: json['colorCode'],
      quantity: json['quantity'],
    );
  }

  // to Json
  Map<String, dynamic> toJson() {
    return {
      'colorName': colorName, 
      'colorCode': colorCode,
      'quantity': quantity,
    };
  }
}

class ProductSizeModel {
  final String? sizeName;
  final int? quantity;

  ProductSizeModel({this.sizeName, this.quantity});

  // from Json
  factory ProductSizeModel.fromJson(Map<String, dynamic> json) {
    return ProductSizeModel(
      sizeName: json['sizeName'],
      quantity: json['quantity'],
    );
  }

  // to Json
  Map<String, dynamic> toJson() {
    return {
      'sizeName': sizeName,
      'quantity': quantity,
    };
  }
}
