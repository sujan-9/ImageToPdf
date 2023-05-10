import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/image_provider.dart';
import '../editscreen/editscreen.dart';



class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget>  createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
        
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const  Text('Chosse one option',style: TextStyle(
                fontSize: 15,
                //fontWeight: FontWeight.bold,
                
                ),),
               const  SizedBox(height: 20,),
               TextButton(
             
             onPressed: (){
               // ref.read(imgNotifierProvider.notifier).pickImagesFromCamera();
                 Navigator.of(context).pop();
               

             },
              child: const Text('Camera',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
                ),),
              
            ),
             TextButton(
              onPressed: (){
               
                 ref.read(imgNotifierProvider.notifier).pickImagesFromGallery();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  EditScreen()));
            //      if (ref.read(imgNotifierProvider.notifier).selectedImages.isNotEmpty) {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditScreen()));}
            //  else{
            //     Navigator.of(context).pop();
            //  }
              },
              child: const Text('Gallery',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
                ),),
              
            ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
              
            ),
           
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
   // final height = MediaQuery.of(context).size.height;
   // final width = MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
         
          body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
            children:   [
                        const Center(child: Text("Image")),
                       const Text("No image is Selected"),
                        const Text("Select an image to start editing"),
                        const SizedBox(height: 20,),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.red),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.purple)
                              )
                            )
                          
                          ),
                          onPressed: () {
                            _showDialog();},
                           child: const Text('Select Images',
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           ),
                           
                           ))

                        
                
      
                    
      
      
                    
            ]),
            
        ),
      ),
    );
  }
 
}