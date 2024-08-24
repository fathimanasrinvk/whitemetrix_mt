import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';
import 'package:whitematrix_mt/presentation/checkout-screen/view/checkout_screeen.dart';
import '../../../core/constants/colors.dart';
import '../../product_screen/controller/product_controller.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double size = constantsize(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      appBar: AppBar(
        backgroundColor: ColorTheme.secondarycolor,
        title: Text('Your Cart',style: GlobalTextStyles.mainTittle,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.cart.length,
              itemBuilder: (context, index) {
                final product = productProvider.cart[index];
                return ListTile(
                  leading: Container(
                      height:size* 400,
                      child: Image.asset(product.imageUrl,fit: BoxFit.fitHeight,)),
                  title: Text(product.name),
                  subtitle: Column(
                    children: [
                      Text('Quantity: ${product.quantity}'),
                      Text('\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.brown),
                    onPressed: () {
                      productProvider.removeFromCart(product);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(size*16.0),
            child: Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: Text(
                    'Total: \$${productProvider.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
                SizedBox(width:size* 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CheckoutScreen()),
                    );
                  },
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
