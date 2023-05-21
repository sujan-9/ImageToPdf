import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // shape: Border(
          //   bottom: BorderSide(
          //     color: Colors.red,
          //     width: 1.8.w,
          //   ),
          // ),
           automaticallyImplyLeading: false,
          shape: const Border(
            bottom: BorderSide(
              color: Colors.red,
              width: 1.8,
            ),
          ),
          title: Text('Setting',
          style : TextStyle(
            fontSize: 27.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'nunito',
            color: Colors.black,
            letterSpacing: 1
          ),
          ),
          centerTitle: true,
        ),
        body:Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.09,
           //vertical: MediaQuery.of(context).size.height * 0.05,
          ),
          child: Column(
           
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06),
               _container(context, _text('About Us')),
              _container(context, _text('Rate us')),
              
              _container(context, _text('Share App')),
              _container(context, _text('Privacy Policy')),
             // _container(context, const Text('Terms & Condition')),
             // _container(context, const Text('Contact Us')),
             // _container(context, const Text('FAQs')),
            //  _container(context, _text('Remove Ads')),
             // _container(context, const Text('Restore Purchase')),
             // _container(context, const Text('Version')),
            ]
          ),
        )
          
        
      ),
    );
  }
  Widget _container(
    BuildContext context,
    Widget child,
  ){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.all(10.w),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                      ),
                       decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(17.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: child,
    );
  }
  Widget _text (
    String text,
  )
  {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
          color: Colors.black,
        ),
      ),
    );}
}