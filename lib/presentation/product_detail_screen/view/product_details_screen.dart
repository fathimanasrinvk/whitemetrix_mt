import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';
import '../../../core/constants/colors.dart';
import '../../../model/product_model.dart';
import '../../cart_screen/view/cart_screen.dart';
import '../../product_screen/controller/product_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    double size = constantsize(context);
    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      appBar: AppBar(
        backgroundColor: ColorTheme.secondarycolor,
        title: Text(product.name,style: GlobalTextStyles.mainTittle),centerTitle: true,),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(size*20),
          child: Column(
            children: [
              Image.asset(product.imageUrl),
              SizedBox(height: size*20,),
          Text(
            product.name,
            style: TextStyle(
              fontSize: size * 24,
              fontWeight: FontWeight.bold,
              color: ColorTheme.maincolor,
            ),),
            SizedBox(height: size*10,),
              Text(
                '\$${product.price}',
                style: TextStyle(
                  fontSize: size * 20,
                  fontWeight: FontWeight.bold,
                  color: ColorTheme.maincolor,
                ),
              ),              SizedBox(height: size * 20),
              Text(
               product.description,
                style: TextStyle(
                  fontSize: size * 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: size*40,),
                 Padding(
                   padding:  EdgeInsets.only(left:size* 60),
                   child: Row(
                    children: [
                      ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          backgroundColor:ColorTheme.maincolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  7))),
                          onPressed: () {
                            Provider.of<ProductProvider>(context, listen: false)
                                .addToCart(product);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => CartPage(),
                              ),
                            );
                      }, child: Text('Add to Cart',style: TextStyle(color: ColorTheme.white),)),
                      SizedBox(width: size*20,),


                      ElevatedButton(
                          style:  ElevatedButton.styleFrom(
                              backgroundColor:ColorTheme.maincolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      7))),
                          onPressed: () {


                          }, child: Text('Buy Now',style: TextStyle(color: Colors.white))),
                    ],
                                 ),
                 ),


            ],
          ),
        ),
      ),
    );
  }
}
