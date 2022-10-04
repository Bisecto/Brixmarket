import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

import '../../../res/strings.dart';


class UpdateApp extends StatefulWidget {
  const UpdateApp({Key? key}) : super(key: key);

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Image.asset('assets/images/brix-logo-dark.png',height: 200,width: 200,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text('Time To Update',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.red,
                  ),),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('We added lots of new features and fixed some bugs to make your experience as smooth as possible',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),),
                  )
                ],
              ),
              GestureDetector(
                onTap: ()async{
                  if (Platform.isAndroid) {
                    if (await canLaunch(Str.downloadAndroidLink)) {
                      await launch(Str.downloadAndroidLink);
                    }
                    else {
                      throw 'Could not launch ${Str.downloadAndroidLink}';
                    }

                    //launch("https://play.google.com/store/apps/details?id=com.jithvar.gambhir_mudda");
                  } else if (Platform.isIOS) {
                    // iOS-specific code
                    if (await canLaunch(Str.downloadIOSLink)) {
                      await launch(Str.downloadIOSLink);
                    }
                    else {
                      throw 'Could not launch ${Str.downloadIOSLink}';
                    }
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: const Text("Update",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }
}
