import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitematrix_mt/presentation/loginscreen/view/login_screen.dart';
import 'package:whitematrix_mt/presentation/product_screen/controller/product_controller.dart';
import 'package:whitematrix_mt/presentation/product_screen/view/product_screen.dart';
import 'package:whitematrix_mt/presentation/signup_screen/view/signup_screen.dart';
import 'package:whitematrix_mt/presentation/splash_screen/view/splash_sacreeen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBefDZEZuiukmb6aIppClRHXQVcaZinO8k",
        appId: "1:688129441156:android:e0f736edb55ed0362631d1",
        messagingSenderId: "",
        projectId: "whitematrix-df247")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
