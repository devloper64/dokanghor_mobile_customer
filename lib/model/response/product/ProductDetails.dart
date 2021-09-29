class ProductDetails {
    String? brand;
    List<String>? colors;
    String? gender;
    int? id;
    List<String>? size_details;
    String? size_mesaurments;
    List<String>? styles;

    ProductDetails({this.brand, this.colors, this.gender, this.id, this.size_details, this.size_mesaurments, this.styles});

    factory ProductDetails.fromJson(Map<String, dynamic> json) {
        return ProductDetails(
            brand: json['brand'], 
            colors: json['colors'] != null ? new List<String>.from(json['colors']) : null, 
            gender: json['gender'], 
            id: json['id'], 
            size_details: json['size_details'] != null ? new List<String>.from(json['size_details']) : null, 
            size_mesaurments: json['size_mesaurments'], 
            styles: json['styles'] != null ? new List<String>.from(json['styles']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['brand'] = this.brand;
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['size_mesaurments'] = this.size_mesaurments;
        if (this.colors != null) {
            data['colors'] = this.colors;
        }
        if (this.size_details != null) {
            data['size_details'] = this.size_details;
        }
        if (this.styles != null) {
            data['styles'] = this.styles;
        }
        return data;
    }
}