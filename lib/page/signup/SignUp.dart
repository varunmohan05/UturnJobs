import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:UturnJobs/const/page_str_const.dart';
import 'package:UturnJobs/util/TnC.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
bool saving3=false;
class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp>
     {
  final GlobalKey<ScaffoldState> _scaffoldKeySignUpPage =
  new GlobalKey<ScaffoldState>();
  final _auth = FirebaseAuth.instance;
  var newUser;
  bool visibility = false;
  bool accountCreated=false;
  bool tncCheck=false;
  bool privacyCheck=false;
  String email;
  String password;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool _obscureTextEmployee = true;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(new FocusNode()); },
      child: new Scaffold(
        appBar: AppBar(title: Text("SIGN UP",style: TextStyle(color:
        Color(0xff01D45B),letterSpacing: 3),),backgroundColor: Color(0xFF1E3C44) ,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
              onTap:(){Navigator.pop(context);},
              child: Icon(Icons.arrow_forward_ios,color:Color(0xff01D45B) ,)),),      key: _scaffoldKeySignUpPage,
        body: ModalProgressHUD(
          inAsyncCall: saving3,
          child: SingleChildScrollView(
                child: Container(
                  color: Color(0xFF1E3C44),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height >= 775.0
                      ? MediaQuery.of(context).size.height
                      : 775.0,

                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: new Image(
                            width: 250.0,
                            height: 191.0,
                            fit: BoxFit.fill,
                            image: new AssetImage('assets/images/signup/login_logo.png')),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:40.0),
                        child: Center(
                          child: Text(
                            "Create account!",
                            style: TextStyle(
                              color: Color(0xff01D45B),
                              letterSpacing: 3,
                              fontSize: 30.0,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),

                      _buildEmployee(context),


                      ]
                  ),
                ),
              ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKeySignUpPage.currentState?.removeCurrentSnackBar();
    _scaffoldKeySignUpPage.currentState.showSnackBar(new SnackBar(
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



  Widget _buildEmployee(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 295.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: emailController,
                          onChanged: (value){
                            email=value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,fontWeight: FontWeight.bold ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Color(0xff00CCFF),
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle( fontSize: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 25.0, right: 25.0),
                        child: TextField(
                          controller: passwordController,
                          onChanged: (value){
                            password=value;
                          },
                          obscureText: _obscureTextEmployee,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black,fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              color: Color(0xff00CCFF),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle( fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleEmployee,
                              child: Icon(
                                _obscureTextEmployee
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Color(0xff00CCFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 0.0, left: 0.0, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              activeColor: Color(0xff00CCFF),
                              value: tncCheck,
                              onChanged: (bool value) {
                                if(value==true)
                                  {
                                    Alert(
                                        context: context,
                                        title: "Terms and Conditions",
                                        content: Container(
                                            height: MediaQuery.of(context).size.height/2,
                                            child: SingleChildScrollView(child: Text(tnc,style: TextStyle(fontSize: 9),))),

                                        buttons: [
                                          DialogButton(
                                            color: Colors.grey,
                                            onPressed: () => Navigator.pop(context),
                                            child: Text(
                                              "Decline",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                          ),
                                          DialogButton(
                                            color: Color(0xff00CCFF),

                                            onPressed: () {Navigator.pop(context);
                                            setState(() {
                                              tncCheck = value;
                                            });
                                            },
                                            child: Text(
                                              "Accept",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                          )
                                        ]).show();

                                  }
                                else
                                  setState(() {
                                    tncCheck = value;
                                  });

                              },
                            ),
                            Container(
                                width: 205,
                                child: Text("I have read the terms and conditions and accept them.",style: TextStyle(fontSize: 12),)),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, bottom: 0.0, left: 0.0, right: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Checkbox(
                              activeColor: Color(0xff00CCFF),
                              value: privacyCheck,
                              onChanged: (bool value) {
                                if(value==true)
                                  Alert(
                                      context: context,
                                      title: "Privacy Policy",
                                      content: Container(
                                          height: MediaQuery.of(context).size.height/2,
                                          child: SingleChildScrollView(child: Text(privacy,style: TextStyle(fontSize: 9)))),

                                      buttons: [
                                        DialogButton(
                                          color: Colors.grey,
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            "Decline",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        DialogButton(
                                          color: Color(0xff00CCFF),

                                          onPressed: () async{Navigator.pop(context);
                                          setState(() {
                                            privacyCheck = value;
                                          });
                                          },
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        )
                                      ]).show();
                                else
                                  setState(() {
                                    privacyCheck = value;
                                  });

                              },
                            ),
                            Container(
                                width: 205,
                                child: Text("I have read the privacy policy and accept them.",style: TextStyle(fontSize: 12),)),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.only(top: 275.0),
                child: RaisedButton(
                    color:Color(0xff00CCFF),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,fontSize: 20),
                      ),
                    ),
                    onPressed:  () async{
                      setState(() {
                        saving3=true;
                      });
                      try {
                        if(emailController.text.isEmpty||passwordController.text.isEmpty)
                          showInSnackBar('Please fill all the fields');
                        else
                        if(tncCheck==false||privacyCheck==false)
                          showInSnackBar('Please check the boxes');
                        else
                        if(newUser==null) {
                          newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          await newUser.sendEmailVerification();
                          showDialog(
                              context: context,builder: (_) => AssetGiffyDialog(
                            image: Image.asset('assets/images/signup/emailsent.png',fit: BoxFit.contain,),
                            title: Text('Verify Your Email',
                              style: TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.w600),
                            ),
                            description: Text('Please click on the verification link sent on your email to verify your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                            buttonOkColor: Color(0xff00CCFF),
                            onOkButtonPressed: ()async {

                              Navigator.pushNamedAndRemoveUntil(_scaffoldKeySignUpPage.currentContext, PAGES[0], (Route<dynamic> route) => false);


                            },
                          ) );
                        }



                      } catch (e) {
                        setState(() {
                          saving3=false;
                        });
                        showInSnackBar("${e.message}");
                      }
                      setState(() {
                        saving3=false;
                      });

                    },

              ),)
            ],
          ),
        ],
      ),
    );
  }


  void _toggleEmployee() {
    setState(() {
      _obscureTextEmployee = !_obscureTextEmployee;
    });
  }



}
