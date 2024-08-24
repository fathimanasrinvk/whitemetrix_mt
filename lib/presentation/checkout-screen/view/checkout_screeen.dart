import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';
import '../../pdf_screen/view/pdf_screen.dart';
import '../../product_screen/controller/product_controller.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _paymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    double size = constantsize(context);

    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      appBar: AppBar(
        backgroundColor: ColorTheme.secondarycolor,
        title: Text('Checkout',style: GlobalTextStyles.mainTittle,),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(size*20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:  EdgeInsets.all(size*16.0),
              decoration: BoxDecoration(
                color: Colors.brown[400],
                borderRadius: BorderRadius.circular(size*8.0),
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.maincolor,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size*10),
                  ListView.builder(
                    itemCount: productProvider.cart.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final product = productProvider.cart[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('${product.name}',style: GlobalTextStyles.thirdTittle,),
                        subtitle: Text('Quantity: ${product.quantity}',style: GlobalTextStyles.thirdTittle,),
                        trailing: Text('\$${(product.price * product.quantity).toStringAsFixed(2)}',style: GlobalTextStyles.thirdTittle,),
                      );
                    },
                  ),
                  SizedBox(height: size*10),
                  Text(
                    'Total: \$${productProvider.totalPrice.toStringAsFixed(2)}',
                    style: GlobalTextStyles.thirdTittle,
                  ),
                ],
              ),
            ),
            SizedBox(height: size*30),
            Text('Select Payment Method:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: ColorTheme.maincolor)),
            RadioListTile(
              activeColor: Colors.brown,
              title: Text('Cash on Delivery'),
              value: 'Cash on Delivery',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            RadioListTile(
              activeColor: Colors.brown,
              title: Text('Google Pay'),
              value: 'Google Pay',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            SizedBox(height:size* 20),

            // Buy Now Button
            Center(
              child: ElevatedButton(
                style:  ElevatedButton.styleFrom(
                    backgroundColor:Colors.brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            7))),
                onPressed: () async {
                  String transactionId = 'TXN${DateTime.now().millisecondsSinceEpoch}';
                  DateTime purchaseDate = DateTime.now();

                  // Generate PDF receipt
                  final pdfService = PdfService();
                  final pdf = await pdfService.generateReceipt(
                    products: productProvider.cart,
                    totalPrice: productProvider.totalPrice,
                    transactionId: transactionId,
                    purchaseDate: purchaseDate,
                  );

                  // Save or share the PDF receipt
                  await pdfService.saveOrSharePdf(pdf);

                  // Clear the cart after purchase
                  productProvider.clearCart();

                  // Notify user of successful purchase
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorTheme.white,
                        content: Text('Purchase successful with $_paymentMethod!',style: GlobalTextStyles.mainTittle,)),
                  );
                },
                child: Text('Buy Now',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
