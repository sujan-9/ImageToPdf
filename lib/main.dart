import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:imagetopdf/core/permission.dart';
import 'feature/bottombar/bootombar.dart';
//import 'feature/selectimage/selectview.dart';
//import 'feature/homepage/homescreen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await Hive.openBox('pdf');
  runApp(const ProviderScope(child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white),

      ),
     // home: const  SelectSource(),
      
     home : const BottomBar()

    );
  }
}

