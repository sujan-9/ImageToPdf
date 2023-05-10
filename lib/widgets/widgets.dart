import 'package:flutter/material.dart';

 snackbar(
  BuildContext context,
  String message,
){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
     // width: 120,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      
  
      content: Center(
        child: Text(message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          //fontWeight: FontWeight.w500,
        ),),
      ),
      duration:const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    //  margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 100,
    //     right: 20,
    //     top: 10,
    //     left: 20),
      padding: const EdgeInsets.all(5),
    ),
    
  );
}
// void snacbar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//     ),
//   );
//}