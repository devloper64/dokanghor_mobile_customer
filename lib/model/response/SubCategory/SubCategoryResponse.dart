class SubCategoryResponse {
    int? categoryId;
    String? categoryName;
    String? createdBy;
    String? createdDate;
    int? id;
    String? image;
    String? lastModifiedBy;
    String? lastModifiedDate;
    String? name;

    SubCategoryResponse({this.categoryId, this.categoryName, this.createdBy, this.createdDate, this.id, this.image, this.lastModifiedBy, this.lastModifiedDate, this.name});

    factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
        return SubCategoryResponse(
            categoryId: json['categoryId'], 
            categoryName: json['categoryName'], 
            createdBy: json['createdBy'], 
            createdDate: json['createdDate'], 
            id: json['id'], 
            image: json['image'], 
            lastModifiedBy: json['lastModifiedBy'], 
            lastModifiedDate: json['lastModifiedDate'], 
            name: json['name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['categoryId'] = this.categoryId;
        data['categoryName'] = this.categoryName;
        data['createdBy'] = this.createdBy;
        data['createdDate'] = this.createdDate;
        data['id'] = this.id;
        data['image'] = this.image;
        data['lastModifiedBy'] = this.lastModifiedBy;
        data['lastModifiedDate'] = this.lastModifiedDate;
        data['name'] = this.name;
        return data;
    }
}