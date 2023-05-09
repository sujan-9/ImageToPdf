import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/feature/bottombar/provider.dart';
import 'package:imagetopdf/feature/homepage/homescreen.dart';

import '../selectimage/selectview.dart';
import '../setting/lpdf_list.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
  const Homepage(),
  const SelectSource(),
   const PDFList(),
  ];
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var navindex = ref.watch(navProvider).index;
    
    return Scaffold(
      body: _widgetOptions.elementAt(navindex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        showUnselectedLabels: false,
        //showSelectedLabels: false,
        currentIndex: navindex,
        onTap: (index) {
          ref.read(navProvider.notifier).changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Image'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      )
    );
  }
  
}