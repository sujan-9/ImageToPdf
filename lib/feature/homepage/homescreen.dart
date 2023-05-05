import 'package:flutter/material.dart';



class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
         
          body:Column(
            children:  [
                 Container(
                      height:height*0.093,
                     // width: 30,
                     margin: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children:[
                          TextButton(
                            onPressed: (){
                            //   if (options.isEmpty){
                            //    return null;
                            //   }else{
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Converter()));
                            //   }
                             
                             },
                           child: const Text("Edit",
                           style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            )
                            ),
                            SizedBox(width: width*0.35,),
                           const TextButton(
                              onPressed: null,
                           child: Text("Save",
                           style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            )
                            ),
                            IconButton(
                          onPressed: (){
                           
                          },  icon:const Icon(Icons.more_vert))
                           
                        ]
                      ),
                    ),
                    
                    //body for images
      
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child:
                            Column(
                           // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:const [
                              Text("Image"),
                              Text("No image is Selected"),
                              Text("Select an image to start editing"),
                            ],
                        )
              //              : 
              //             Container(
              // height: height*0.66,
              // decoration: BoxDecoration(
                
              //   color: Colors.grey,
              //   borderRadius: BorderRadius.circular(10),
              // ),
              // child: ListView.builder(
              //   scrollDirection: Axis.horizontal,
              //   itemCount: options.length,
              //   itemBuilder: (context, index) => Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 5),
              //     child:  Stack(
              //       children: [
              //         Image.file(
              //           options[index],
              //           // width: 100,
              //           // height: 100,
              //           fit : BoxFit.fill,
              //         ),]))))
                        
                      )
                    ),
                    ),
      
      
                    
            ]),
            
        ),
      ),
    );
  }
}