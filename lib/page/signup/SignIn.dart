import 'package:UturnJobs/const/page_str_const.dart';
import 'package:UturnJobs/util/UsefulVariables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:toast/toast.dart';

import '../../const/styles.dart';
final GlobalKey<ScaffoldState> _scaffoldKeyLoginPage = new
GlobalKey<ScaffoldState>();
final _auth = FirebaseAuth.instance;
FirebaseUser user;
TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
TextEditingController resetController=TextEditingController();

bool saving=false;
final _firestore = Firestore.instance;
class SignIn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode()); },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        key: _scaffoldKeyLoginPage,
        body:  Container(
            padding: EdgeInsets.only(top: 30.0),
            color: Color(0xFF1E3C44),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Center(
                  child: Image.asset('assets/images/logo.png',width: 180,)),
                headlinesWidget(),
                emailTextFieldWidget(),
                passwordTextFieldWidget(),

                linkWidget('',(){
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {return AlertDialog(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(20) ) ,
                        title: Text('Enter your registered email id'),
                        content: Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20,
                              bottom: 10,top: 5),
                          child: TextField(
                            style: TextStyle(color:
                            Color(0xFF1E3C44),fontFamily: 'Montserrat' ),
                            decoration: InputDecoration(hintText:
                            'example@abc.com',hintStyle:
                            TextStyle(color: Colors.grey,fontFamily: 'Montserrat' )),
                            controller: resetController,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),

                        actions: <Widget>[

                          Padding(
                            padding: const EdgeInsets.only(right:20.0),
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                color: Colors.grey,
                                elevation: 8,
                                disabledElevation: 0,
                                child: Container(child: Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))),
                                onPressed:(){Navigator.pop(context);
                                resetController.clear();}
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(right:20.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              color: Color(0xff00CCFF),
                              elevation: 8,
                              child: Container(child: Text('Send Reset Link',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                              onPressed: ()async { {
                                Navigator.of(context).pop();
                               try {
                                 await _auth.sendPasswordResetEmail(
                                     email: resetController.text);


                                Toast.show(
                                  'Password reset link sent, check your mail',
                                  _scaffoldKeyLoginPage.currentContext,
                                  duration: 7,
                                  gravity: Toast.CENTER,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                );  }
                               catch(e)
                               {
                                 Toast.show(
                                   '${e.message}',
                                   _scaffoldKeyLoginPage.currentContext,
                                   duration: 4,
                                   gravity: Toast.CENTER,
                                   backgroundColor: Colors.white70,
                                   textColor: Colors.black,
                                 );
                               }}

                              },
                            ),
                          )
                        ],
                      );
                      });

                }
                  ,'Reset password')
                ,
                LoginButton(),
                linkWidget('Don\'t have an account?',() {
                  Navigator.pushNamed(_scaffoldKeyLoginPage.currentState.context,PAGES[1]);
                  print('Sign Up button pressed');
                  emailController.clear();
                  passController.clear();
                },'Sign Up'),
              ],
            ),
          ),
      ),
    );
  }
}

Widget linkWidget(String text,Function function, String title) {
  return Container(
    margin: EdgeInsets.only( top: 2.0),
    child: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 11,fontFamily: 'Montserrat',color: Color(0xff01D45B),),
        ),
        FlatButton(
          onPressed: function,
          child: Text(
            title,
            style: TextStyle(
                color: Color(0xff01D45B),
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
            fontSize: 12),
          ),
        )
      ],
    ),
  );
}

Widget passwordTextFieldWidget() {
  return Container(
    margin: EdgeInsets.only(left: 25.0, right: 25.0,top: 15),
    child: TextField(
      controller: passController,
      style: TextStyle(color: Color(0xFF1E3C44),
          fontSize: 15.0,
          fontFamily: 'Montserrat',fontWeight: FontWeight.bold ),
      obscureText: true,
      decoration: new InputDecoration(
          suffixIcon: Icon(Icons.lock,
              color: Color(0xff00CCFF), size: 30.0),
          fillColor: Colors.white,
          filled: true,
          contentPadding: new EdgeInsets.fromLTRB(40.0, 20.0, 10.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          hintText: 'Password',
          hintStyle: hintAndValueStyle),
    ),
  );
}

Widget emailTextFieldWidget() {
  return Container(
    margin: EdgeInsets.only(left: 25.0, right: 25.0, top: 32.0),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              spreadRadius: 0,
              offset: Offset(0.0, 16.0)),
        ],
        borderRadius: new BorderRadius.circular(12.0),
        color: Colors.white),
    child: TextField(
      controller: emailController,
      style: TextStyle(color: Color(0xFF1E3C44),
          fontSize: 15.0,
          fontFamily: 'Montserrat' ,fontWeight: FontWeight.bold ),

      decoration: new InputDecoration(

          suffixIcon: Icon(Icons.email,
              color: Color(0xff00CCFF), size: 30.0),
          contentPadding: new EdgeInsets.fromLTRB(40.0, 20.0, 10.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          hintText: 'Email',
          hintStyle: hintAndValueStyle),
    ),
  );
}

Widget headlinesWidget() {
  return Container(
    margin: EdgeInsets.only(left: 32.0,right: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Text(
            'One-Time Jobs',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff00CCFF),
                letterSpacing: 3,
                fontSize: 22.0,
                fontFamily: 'Montserrat',
                ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 32,top: 40.0,bottom: 10),
          child: Text(
            'Log in \nto continue.',
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Color(0xff01D45B),
              letterSpacing: 3,
              fontSize: 32.0,
              fontFamily: 'Montserrat',
            ),
          ),
        )
      ],
    ),
  );
}
class LoginButton extends StatefulWidget {
  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void showInSnackBar(String value) {
    FocusScope.of(_scaffoldKeyLoginPage.currentContext).requestFocus(new FocusNode());
    _scaffoldKeyLoginPage.currentState?.removeCurrentSnackBar();
    _scaffoldKeyLoginPage.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
  DocumentReference docRef;
  DocumentSnapshot doc;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: saving==false?RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Color(0xff00CCFF),
          onPressed: ()async {try{
            setState(() {
              saving=true;
            });
            user =
            await _auth.signInWithEmailAndPassword(
                email: emailController.text, password: passController.text);
            if (user != null&&user.isEmailVerified==true&&user.phoneNumber.toString().isNotEmpty)
              docRef=_firestore.collection('UserProfiles').document(emailController.text);
            doc= await docRef.get();
            if (doc.data != null) {
              Variable.newUser = false;
              Navigator.pushNamedAndRemoveUntil(
                  _scaffoldKeyLoginPage.currentState.context, PAGES[3], (
                  Route<dynamic> route) => false);
            }
            else {
              Variable.newUser = true;
              Navigator.pushNamed(
                  _scaffoldKeyLoginPage.currentContext, PAGES[2]);
            }
            Variable.email=emailController.text;
            Variable.password=passController.text;
          }
          catch(e){
            setState(() {
              saving=false;
            });
            showInSnackBar('Please Retry')  ;
          }
          setState(() {
            saving=false;
          });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 10.0),
            child: Text('Login',style: TextStyle(letterSpacing: 1,fontSize: 20,color: Colors.white,fontFamily: 'Montserrat'),),
          ),

        ):Center(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircularProgressIndicator(backgroundColor: Color(0xff00CCFF) ,),
        )),
      ),
    );
  }
}


