 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget titletext (
    String text,
  )
  {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
      ),
    );}