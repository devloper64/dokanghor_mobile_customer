class ProductDetails {
    String? brand;
    String? color;
    String? gender;
    int? id;
    String? size_details;
    String? size_mesaurments;
    String? style;

    ProductDetails({this.brand, this.color, this.gender, this.id, this.size_details, this.size_mesaurments, this.style});

    factory ProductDetails.fromJson(Map<String, dynamic> json) {
        return ProductDetails(
            brand: json['brand'], 
            color: json['color'], 
            gender: json['gender'], 
            id: json['id'], 
            size_details: json['size_details'], 
            size_mesaurments: json['size_mesaurments'], 
            style: json['style'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['brand'] = this.brand;
        data['color'] = this.color;
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['size_details'] = this.size_details;
        data['size_mesaurments'] = this.size_mesaurments;
        data['style'] = this.style;
        return data;
    }
}