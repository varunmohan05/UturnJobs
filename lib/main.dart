import 'package:UturnJobs/page/feed/FailedPayments.dart';
import 'package:UturnJobs/page/feed/FeedProfile.dart';
import 'package:UturnJobs/page/feed/JobListings.dart';
import 'package:UturnJobs/page/feed/NewUser.dart';
import 'package:UturnJobs/page/feed/SuccessfulPayments.dart';
import 'package:UturnJobs/page/signup/CreateJob.dart';
import 'package:UturnJobs/page/signup/CreateProfile.dart';
import 'package:UturnJobs/page/signup/SignIn.dart';
import 'package:UturnJobs/page/signup/SignUp.dart';
import 'package:UturnJobs/util/SizeUtil.dart';
import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'const/string_const.dart';

void main()
{
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).
    then((val){
      return runApp(MyApp());

  });


  }

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: StringConst.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       // primaryColor: ,
       // accentColor: ,
        fontFamily: "Montserrat",
      ),
      home: FutureBuilder<FirebaseUser>(
          future: auth.currentUser(),
          builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot)
          {
            switch (snapshot.connectionState)  {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else
                if(snapshot.data == null){
                  SizeUtil.size = MediaQuery.of(context).size;
                  return SignIn();}
                else {
                  SizeUtil.size = MediaQuery.of(context).size;
                  if(snapshot.data.isEmailVerified&&snapshot.data.phoneNumber.toString().length==13) {
                    Variable.email=snapshot.data.email;
                    Variable.newUser = false;
                    return JobListings();
                  }
                  else {
                  return SignIn();
                  }
                }
            }

          }
      ),

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'SignIn':
            return PageTransition(child: SignIn(), type: PageTransitionType.rightToLeft);
            break;
          case 'SignUp':
            return PageTransition(child: SignUp(), type: PageTransitionType.rightToLeft);
            break;
          case 'CreateProfile':
            return PageTransition(child: CreateProfile(), type: PageTransitionType.rightToLeft);
            break;
          case 'JobListings':
            return PageTransition(child: JobListings(), type: PageTransitionType.rightToLeft);
            break;
          case 'CreateJob':
            return PageTransition(child: CreateJob(), type: PageTransitionType.downToUp);
            break;
          case 'FeedProfile':
            return PageTransition(child: FeedProfile(), type: PageTransitionType.rightToLeft);
            break;
          case 'SuccessfulPayments':
            return PageTransition(child: SuccessfulPayments(), type: PageTransitionType.rightToLeft);
            break;
          case 'FailedPayments':
            return PageTransition(child: FailedPayments(), type: PageTransitionType.rightToLeft);
            break;
          case 'NewUser':
            return PageTransition(
                child: NewUser(), type: PageTransitionType.fade);
            break;
          default:
            return null;
        }
      },
    );
  }
}
