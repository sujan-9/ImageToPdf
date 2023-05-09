import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/feature/editscreen/editscreen.dart';

import '../../core/image_provider.dart';
import '../bottombar/bootombar.dart';




// class SelectSource extends ConsumerWidget {
//   const SelectSource({super.key});


//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
    
  

//    //final opt = ref.watch(imgNotifierProvider.notifier).selectedImages;
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//           TextButton(onPressed: (){
//             //opt.pickImagesFromGallery();
//             ref.read(imgNotifierProvider.notifier).pickImagesFromGallery();
//               Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditScreen()));
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.blue),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 side: const BorderSide(color: Colors.blue)
//               )
//             )
          
//           ),
//            child: const Text("Gallery")),
//            const  TextButton(onPressed: null,
//            child: Text("Camera")),
//            TextButton(onPressed: (){
//             //opt.pickImagesFromGallery();
//             //ref.read(imgNotifierProvider.notifier).();
//            // Navigator.push(context, MaterialPageRoute(builder: (context) =>  PdfViewerScreen(path: path,)));
//           },
//           style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.all(Colors.blue),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 side: const BorderSide(color: Colors.blue)
//               )
//             )
          
//           ),
//            child: const Text("saved pdf")),
//         ],),
//       ),
//     );

//   }
// }

class SelectSource extends ConsumerWidget {
  const SelectSource({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final opt = ref.watch(imgNotifierProvider.notifier).selectedImages;
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
                // ref.read(selectedImagesProvider.notifier).pickImagesFromCamera();
                 // Navigator.of(context).pop();
               

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
             Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditScreen()));
              },
              child: const Text('Gallery',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                
                ),),
              
            ),

            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () =>Navigator.pop(context),
          //     // Navigator.of(context).pop(),
              
          //     child: const Text('Close'),
              
          //   ),
           
          // ],
        );
  }
}