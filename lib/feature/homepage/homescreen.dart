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
                ref.read(imgNotifierProvider.notifier).pickImagesFromCamera();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EditScreen()));
               

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
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EditScreen()));
           
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
   
    DateTime? currentBackPressTime;
   Future<bool> _exitApp(BuildContext context) async {
    // Check if the back button is pressed twice within 2 seconds
    if (currentBackPressTime == null ||
        DateTime.now().difference(currentBackPressTime!) > const Duration(seconds: 2)) {
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
    return  WillPopScope(
      onWillPop: () async => _exitApp(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: const Text(''),
            backgroundColor: Color.fromARGB(255, 231, 54, 54),
            centerTitle: true,
            elevation: 2,
            title: const Text('PDF Maker',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              

            ),),
          ),
         
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