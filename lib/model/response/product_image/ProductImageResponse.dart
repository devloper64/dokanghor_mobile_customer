class ProductImageResponse {
    int? id;
    String? image;
    int? productId;

    ProductImageResponse({required this.id, required this.image, required this.productId});

    factory ProductImageResponse.fromJson(Map<String, dynamic> json) {
        return ProductImageResponse(
            id: json['id'], 
            image: json['image'], 
            productId: json['productId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['image'] = this.image;
        data['productId'] = this.productId;
        return data;
    }
}