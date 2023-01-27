import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:job_dekho_app/Utils/CustomWidgets/customDrawerTile.dart';
import 'package:job_dekho_app/Utils/style.dart';
import 'package:get/get.dart';
import 'package:job_dekho_app/Views/Job%20Seeker/FilterPage.dart';
import 'package:job_dekho_app/Views/Recruiter/applied_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/recruiterprofiledetails_Screen.dart';
import 'package:job_dekho_app/Views/changepassword_Screen.dart';
import 'package:job_dekho_app/Views/contactus_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/recruitermyprofile_Screen.dart';
import 'package:job_dekho_app/Views/notification_Screen.dart';
import 'package:job_dekho_app/Views/signin_Screen.dart';
import 'package:job_dekho_app/Views/updatejobpost_Screen.dart';
import 'package:job_dekho_app/Views/privacypolicy_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/searchcandidate_Screen.dart';
import 'package:job_dekho_app/Views/termsandcondition_Screen.dart';
import 'package:job_dekho_app/Views/Recruiter/postJob_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Services/tokenString.dart';
import '../../Utils/iconUrl.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  openLogoutDialog(){
    return showDialog(context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return AlertDialog(
          title: Text("Are you sure want to logout app ?",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  prefs.setString(TokenString.userid, "");
                  setState((){

                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child:  Text("Confirm",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.red,
                  ),
                  child:  Text("Cancel",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share',
        // text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title'
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit an App?'),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: (){
              exit(0);
              // Navigator.pop(context,true);
              // Navigator.pop(context,true);
            },
            //return true when click on "Yes"
            child:Text('Yes'),
          ),
        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 120,
                color: primaryColor,
                child: Image.asset('assets/jobdekho_logo.png', scale: 2,),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                width: size.width,
                height: size.height / 1.2,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(90))
                ),
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomDrawerTile(tileName: 'My Profile', tileIcon: Image.asset(profileIconR, scale: 1.3,),onTap: (){Get.to(RecruiterMyProfileScreen());},),
                    CustomDrawerTile(tileName: 'Post Job', tileIcon: Image.asset(postjobIconR, scale: 1.3,),onTap: (){Get.to(PostJobScreen());}),
                    CustomDrawerTile(tileName: 'Applied', tileIcon: Image.asset(appliedIconR, scale: 1.3,),onTap: (){Get.to(applied_Screen());},),
                    CustomDrawerTile(tileName: 'Change Password', tileIcon: Image.asset(changepasswordIconR, scale: 1.3,), onTap: (){Get.to(ChangePasswordScreen());},),
                    CustomDrawerTile(tileName: 'Share App', tileIcon: Image.asset(shareappIconR, scale: 1.3,),onTap: (){
                      share();
                    },),
                    CustomDrawerTile(tileName: 'Search Candidate', tileIcon: Image.asset(searchIconR,color: primaryColor,scale: 1.3,),onTap: (){Get.to(FilterPgae());},),
                    CustomDrawerTile(tileName: 'Notification', tileIcon: Image.asset(notificationIconR, scale: 1.3,),onTap: (){Get.to(NotificationScreen());}),
                    CustomDrawerTile(tileName: 'Contact Us', tileIcon: Image.asset(contactusIconR, scale: 1.3,), onTap: (){Get.to(ContactUsScreen());},),
                    CustomDrawerTile(tileName: 'Privacy Policy', tileIcon: Image.asset(privactpolicyIconR, scale: 1.3,), onTap: (){Get.to(PrivacyPolicyScreen());},),
                    CustomDrawerTile(tileName: 'Terms & Conditions', tileIcon: Image.asset(termsandconditionIconR, scale: 1.3,),onTap: (){Get.to(TermsAndConditionScreen());},),
                    CustomDrawerTile(tileName: 'Sign Out', tileIcon: Image.asset(signoutIconR, scale: 1.3,),onTap: (){openLogoutDialog();
                    },),
                  ],
                ),
              )
            ],
          ),
        )
      )),
    );
  }
}
