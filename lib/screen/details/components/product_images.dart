import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_customer_app/bloc/ProductImagesListBloc.dart';
import 'package:ecommerce_customer_app/components/LoadingWidget.dart';
import 'package:ecommerce_customer_app/model/response/product/Product.dart';
import 'package:ecommerce_customer_app/model/response/product_image/ProductImageResponse.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';


class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productImageBloc..getProductImages(widget.product.id!);
  }

  @override
  void dispose() {
    super.dispose();
    productImageBloc..drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<bool>(
        stream: productImageBloc.isLoading,
        builder: (context, AsyncSnapshot<bool> snapshot) {

          if(snapshot.data==true){
            return LoadingWidget.buildLoadingWidget();
          }else{
            return   StreamBuilder<List<ProductImageResponse>>(
                stream: productImageBloc.subject.stream,
                builder: (context, AsyncSnapshot<List<ProductImageResponse>> snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.isNotEmpty){
                      return _buildWidget(snapshot.data!);
                    }
                    else{
                      List<ProductImageResponse> list=[];
                      ProductImageResponse productImageResponse=ProductImageResponse(id: widget.product.id, image:  widget.product.image, productId:  widget.product.id);
                      list.add(productImageResponse);
                      return _buildWidget(list);

                    }
                  }
                  else{
                    return LoadingWidget.buildLoadingWidget();
                  }
                }

            );
          }

        });



  }

  Widget _buildWidget(List<ProductImageResponse> list){
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: CachedNetworkImage(
                imageUrl: list[selectedImage].image!,
                errorWidget: (context, url, error) => Image.asset("assets/images/splash_icon.png"),
              ),
            ),
          ),
        ),
         SizedBox(height: getProportionateScreenWidth(20)),
        Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ...List.generate(list.length,
                    (index) => buildSmallProductPreview(index,list)),
          ],
        )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index,List<ProductImageResponse> list) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: CachedNetworkImage(
          imageUrl: list[index].image!,
          errorWidget: (context, url, error) => Image.asset("assets/images/splash_icon.png"),
        ),
      ),
    );
  }
}
