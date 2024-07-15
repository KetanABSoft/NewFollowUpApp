import 'package:flutter/material.dart';
import 'package:followup/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';
import '../generated/assets.dart';
import '../routes/route.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  LoginController loginController = Get.find();
  Razorpay razorpay = Razorpay();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.imagesSubcriptionBg),fit: BoxFit.fitHeight,opacity: 0.8)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height:2.h),
              Container(
                height: 60.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 2.h,),
                    Text("FollowUp",style: TextStyle(color:Color.fromRGBO(143, 148, 251, 1),fontWeight: FontWeight.bold,fontSize: 20.sp),),
                    SizedBox(height: 4.h,),
                    Text("Rs 4999/-",style: TextStyle(color:Color.fromRGBO(143, 148, 251, 1),fontWeight: FontWeight.bold,fontSize: 38.sp),),
                    SizedBox(height: 4.h,),
                    Text("For 1 year up to 10 employee\nPer extra employee ₹ 499/-",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1),fontWeight: FontWeight.bold,fontSize: 15.sp),),
                    SizedBox(height: 2.h,),
                    Lottie.asset(Assets.animationsOfficeemployee,height: 25.h),
                  ],
                ),
                      ),
              SizedBox(height: 5.h,),
              ElevatedButton(
                onPressed: () {
                  var options = {
                    'key': 'rzp_live_cIF1eWIxSXQ5NZ',
                    'amount': 100,
                    'name': 'Follow Up',
                    'currency': 'INR',
                    'timeout': 600,
                    'description': 'Subscription for 1 year upto 10 Employee',
                    'retry': {'enabled': true, 'max_count': 1},
                    'send_sms_hash': true,
                    'prefill': {
                      'contact': '8888732973',
                      'email': 'absoftwaresolution@gmail.com'
                    },
                  };
                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  razorpay.open(options);
                },
                child: Padding(
                  padding: EdgeInsets.all(5.w),
                  child: Text('Subscribe',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.sp),),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0), // Adjust as per your requirement
                      // You can also set other properties like border color, width, etc.
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    )
    );

  }


  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed", "\nDescription: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    bool result = await loginController.subscriptionAPI();
     if(result){
      Get.offAllNamed(Routes.SUCCESS_SCREEN);
     }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
