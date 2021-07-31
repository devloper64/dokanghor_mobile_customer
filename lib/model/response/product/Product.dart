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
    ProductDetails? productDetails;
    int? productTypeId;
    double? quantity;
    int? subCategoryId;
    String? subCategoryName;

    Product({required this.createdBy, required this.createdDate, required this.discount_amount, required this.id, required this.image, required this.lastModifiedBy, required this.lastModifiedDate, required this.name, required this.price, this.productDetails, required this.productTypeId, required this.quantity, required this.subCategoryId, required this.subCategoryName});

    factory Product.fromJson(Map<String, dynamic> json) {
        return Product(
            createdBy: json['createdBy'], 
            createdDate: json['createdDate'], 
            discount_amount: json['discount_amount'], 
            id: json['id'], 
            image: json['image'], 
            lastModifiedBy: json['lastModifiedBy'], 
            lastModifiedDate: json['lastModifiedDate'], 
            name: json['name'], 
            price: json['price'], 
            productDetails: json['productDetails'] != null ? ProductDetails?.fromJson(json['productDetails']) : null, 
            productTypeId: json['productTypeId'], 
            quantity: json['quantity'], 
            subCategoryId: json['subCategoryId'], 
            subCategoryName: json['subCategoryName'], 
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
        if (this.productDetails != null) {
            data['productDetails'] = this.productDetails!.toJson();
        }
        return data;
    }
}