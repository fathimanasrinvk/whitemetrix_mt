import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../../../model/product_model.dart';
class PdfService {
  Future<pw.Document> generateReceipt({
    required List<Product> products,
    required double totalPrice,
    required String transactionId,
    required DateTime purchaseDate,
  }) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Receipt', style: pw.TextStyle(fontSize: 24,color:PdfColors.brown)),
            pw.SizedBox(height: 20),
            pw.Text('Transaction ID: $transactionId',style: pw.TextStyle(fontSize: 24,color:PdfColors.brown)),
            pw.Text('Date of Purchase: ${purchaseDate.toLocal()}'),
            pw.SizedBox(height: 20),
            pw.Text('Products:',style: pw.TextStyle(color:PdfColors.brown)),
            pw.SizedBox(height: 10),
            pw.ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return pw.Text(
                    '${product.name} - ${product.quantity} x \$${product.price}');
              },
            ),
            pw.SizedBox(height: 20),
            pw.Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
          ],
        );
      },
    ));
    return pdf;
  }

  Future<void> saveOrSharePdf(pw.Document pdf) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/receipt.pdf");
    await file.writeAsBytes(await pdf.save());

    // Share or download the PDF
    final xFile = XFile(file.path);
    await Share.shareXFiles([xFile], text: 'Your receipt');
  }
}
