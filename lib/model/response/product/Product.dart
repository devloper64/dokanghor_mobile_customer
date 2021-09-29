import 'ProductDetails.dart';

class Product {
    String? createdBy;
    String? createdDate;
    double? discount_amount;
    int? id;
    String? image;
    String? lastModifiedBy;
    String? lastModifiedDate;
    String? name;
    double? price;
    ProductDetails? productDetailsResponse;
    int? productTypeId;
    double? quantity;
    int? subCategoryId;
    String? subCategoryName;
    int? userId;

    Product({this.createdBy, this.createdDate, this.discount_amount, this.id, this.image, this.lastModifiedBy, this.lastModifiedDate, this.name, this.price, this.productDetailsResponse, this.productTypeId, this.quantity, this.subCategoryId, this.subCategoryName, this.userId});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            createdBy: json['createdBy'], 
            createdDate: json['createdDate'], 
            discount_amount: double.parse(json['discount_amount'].toString()),
            id: json['id'], 
            image: json['image'], 
            lastModifiedBy: json['lastModifiedBy'], 
            lastModifiedDate: json['lastModifiedDate'], 
            name: json['name'], 
            price: double.parse(json['price'].toString()),
            productDetailsResponse: json['productDetailsResponse'] != null ? ProductDetails.fromJson(json['productDetailsResponse']) : null,
            productTypeId: json['productTypeId'], 
            quantity: double.parse(json['quantity'].toString()),
            subCategoryId: json['subCategoryId'], 
            subCategoryName: json['subCategoryName'], 
            userId: json['userId'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['createdBy'] = this.createdBy;
        data['createdDate'] = this.createdDate;
        data['discount_amount'] = this.discount_amount;
        data['id'] = this.id;
        data['image'] = this.image;
        data['lastModifiedBy'] = this.lastModifiedBy;
        data['lastModifiedDate'] = this.lastModifiedDate;
        data['name'] = this.name;
        data['price'] = this.price;
        data['productTypeId'] = this.productTypeId;
        data['quantity'] = this.quantity;
        data['subCategoryId'] = this.subCategoryId;
        data['subCategoryName'] = this.subCategoryName;
        if (this.productDetailsResponse != null) {
            data['productDetailsResponse'] = this.productDetailsResponse!.toJson();
        }
        if (this.userId != null) {
            data['userId'] = this.userId;
        }
        return data;
    }
}