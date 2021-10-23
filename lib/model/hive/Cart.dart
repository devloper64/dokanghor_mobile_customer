import 'package:hive/hive.dart';

part 'Cart.g.dart';

@HiveType(typeId: 0)
class Cart {

  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String? color;

  @HiveField(3)
  final String? size;

  @HiveField(4)
  final String? height;

  @HiveField(5)
  final String? weight;

  @HiveField(6)
  final String? width;

  @HiveField(7)
  final String amount;

  @HiveField(8)
  final String quantity;

  @HiveField(9)
  final String productImage;

  Cart( {required this.productId, required this.productName, this.color, this.size, this.height,
      this.weight, this.width, required this.amount, required this.quantity,required this.productImage});



}