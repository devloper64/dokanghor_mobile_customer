class ProductTypeResponse {
    int? id;
    String? name;
    int? subCategoryId;

    ProductTypeResponse({this.id, this.name, this.subCategoryId});

    factory ProductTypeResponse.fromJson(Map<String, dynamic> json) {
        return ProductTypeResponse(
            id: json['id'], 
            name: json['name'], 
            subCategoryId: json['subCategoryId'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['subCategoryId'] = this.subCategoryId;
        return data;
    }
}