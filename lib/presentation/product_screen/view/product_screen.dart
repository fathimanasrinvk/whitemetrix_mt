import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';
import 'package:whitematrix_mt/presentation/cart_screen/view/cart_screen.dart';
import '../../../service/authservice/auth_service_screen.dart';
import '../../product_detail_screen/view/product_details_screen.dart';
import '../controller/product_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = constantsize(context);
    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: ColorTheme.secondarycolor,
        title: Text('HerAc',style:GlobalTextStyles.mainTittle,),centerTitle: true,),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Padding(
            padding:  EdgeInsets.all(size*8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product)));
                  },
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding:  EdgeInsets.all(size*8.0),
                      child: Column(
                        children: [
                          Expanded(child:
                          Container(
                              child: Image.asset(product.imageUrl,fit: BoxFit.cover,))),
                          SizedBox(height: size*10,),
                          Text(product.name),

                          Padding(
                            padding:  EdgeInsets.only(top:size*10,left:size* 30),
                            child: Row(
                              children: [
                                Text('\$${product.price}'),
                                SizedBox(width:size* 40,),
                                IconButton(
                                   onPressed: () {  Provider.of<ProductProvider>(context, listen: false)
                                    .addToCart(product);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ),
                                ); }, icon:Icon(Icons.shopping_cart,color: Colors.brown,))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
