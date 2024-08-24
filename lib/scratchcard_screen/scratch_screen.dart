import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:whitematrix_mt/core/constants/colors.dart';
import 'package:whitematrix_mt/core/constants/global_textstyles.dart';

class ScratchCard extends StatefulWidget {

  final Function onAddToCart;

  ScratchCard({required this.onAddToCart});

  @override
  State<ScratchCard> createState() => _ScratchCardState();
}

class _ScratchCardState extends State<ScratchCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.secondarycolor,
      appBar: AppBar(
        backgroundColor: ColorTheme.secondarycolor,
        title: Text("SCRATCH ME",style: GlobalTextStyles.mainTittle,),
        centerTitle: true,
      ),
      body: Center(
        child: Scratcher(
          brushSize: 50,
          threshold: 30,
          color: ColorTheme.maincolor,
          onThreshold: () {
            Future.delayed(Duration(milliseconds: 300), () {
              widget.onAddToCart();
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: ColorTheme.maincolor,
                  width: 3,
                ),
              image: DecorationImage(image: AssetImage("assets/images/bgpic.png"),fit: BoxFit.fill)
            ),
            height: 400,
            width: 300,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Congratulations! You have won a free gift",
                  style:GlobalTextStyles.subTitle3,
                  // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
