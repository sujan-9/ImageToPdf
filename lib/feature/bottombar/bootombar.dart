

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imagetopdf/feature/bottombar/provider.dart';
import 'package:imagetopdf/feature/homepage/homescreen.dart';


import '../selectimage/selectview.dart';

import '../setting/settingpage.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
  const Homepage(),
   const SelectSource(),
   const SettingPage(),
  ];
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var navindex = ref.watch(navProvider).index;
     PageController pageController = PageController(initialPage: navindex);


    //double pree to exit
    DateTime? currentBackPressTime;
    Future<bool> exitApp(BuildContext context) async {
      // Check if the back button is pressed twice within 2 seconds
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              const Duration(seconds: 2)) {
        // First back press, show a message
        currentBackPressTime = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        return false; // Prevent the app from closing
      } else {
        // Second back press within 2 seconds, exit the app
        return true; // Let the app close
      }
    }
    
    
    return WillPopScope
    (
      onWillPop: () async => exitApp(context),
      child: Scaffold(
        body: 
        //_widgetOptions.elementAt(navindex),

       PageView.builder(
          controller: pageController,
          itemCount: _widgetOptions.length,
          itemBuilder: (context, index) => _widgetOptions[index],
          onPageChanged: (index) {
            ref.read(navProvider.notifier).changeIndex(index);
          },
        ),




        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          showUnselectedLabels: false,
          //showSelectedLabels: false,
          currentIndex: navindex,
          onTap: (index) {
            ref.read(navProvider.notifier).changeIndex(index);
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home,
            size: 30.sp,
            
            ), label: 'Home',
            
            ),



            const BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf_rounded), label: 'pdf'),
            const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
          ],
        )
      ),
    );
  }
  
}