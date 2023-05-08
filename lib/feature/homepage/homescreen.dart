import 'package:flutter/material.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
            children:  const [
                        Center(child: Text("Image")),
                        Text("No image is Selected"),
                        Text("Select an image to start editing"),

                        
                //  Container(
                //       height:height*0.093,
                //      // width: 30,
                //      margin: const EdgeInsets.all(7),
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Row(
                //         children:[
                //           TextButton(
                //             onPressed: (){
                //             //   if (options.isEmpty){
                //             //    return null;
                //             //   }else{
                //             // Navigator.push(context, MaterialPageRoute(builder: (context) => Converter()));
                //             //   }
                             
                //              },
                //            child: const Text("Edit",
                //            style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             )
                //             ),
                //             SizedBox(width: width*0.35,),
                //            const TextButton(
                //               onPressed: null,
                //            child: Text("Save",
                //            style: TextStyle(
                //               color: Colors.black,
                //               fontSize: 20,
                //               fontWeight: FontWeight.bold,
                //             ),
                //             )
                //             ),
                //             IconButton(
                //           onPressed: (){
                           
                //           },  icon:const Icon(Icons.more_vert))
                           
                //         ]
                //       ),
                //     ),
                    
                    //body for images
      
                    
      
      
                    
            ]),
            
        ),
      ),
    );
  }
}