import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';








class SelectSource extends ConsumerWidget {
  const SelectSource({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
  

  //final opt = ref.watch(imgNotifierProvider.notifier).selectedImages;
  
   getPath ()async{
var path = await SharedPreferences.getInstance();
return path.getString('path');
  }
  print(getPath().toString());
    return  SafeArea(
      child: Scaffold(
        body: Padding(
         padding:  const EdgeInsets.all(20.0),
         child: 
        ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.width * 0.01,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
               // color: Colors.red,
                borderRadius: BorderRadius.circular(17),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
               
              child: Text('hello$index',),
            );
          }),
        
      ),)
    );

  }
}

