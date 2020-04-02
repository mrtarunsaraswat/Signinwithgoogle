import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Google Signin'),
        ),
        body: Center(
            child: _isLoggedIn
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(_googleSignIn.currentUser.photoUrl, height: 90.0, width: 90.0,),
                SizedBox(height: 10,),
                Text(_googleSignIn.currentUser.displayName),
                SizedBox(height: 10,),
                Text(_googleSignIn.currentUser.email),
                SizedBox(height: 10,),
                Text(_googleSignIn.currentUser.id),
                SizedBox(height: 10,),
                Text(_googleSignIn.currentUser.hashCode.toString()),
                RaisedButton.icon(icon: Icon(Entypo.log_out),
                  label: Text("Logout"), onPressed: (){
                  _logout();
                },)
              ],
            )
                : Align(
              alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
              child: RaisedButton.icon(
                  icon: Icon(FontAwesome5Brands.google),
                  label: Text("Login with Google"),
                  onPressed: () {
                    _login();
                  },
              ),
            ),
                )),
      ),
    );
  }
}