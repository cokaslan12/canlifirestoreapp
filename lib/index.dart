import 'package:canlifirestoreapp/forgetpassword.dart';
import 'package:canlifirestoreapp/kaydol.dart';
import 'package:canlifirestoreapp/student/student.dart';
import 'package:canlifirestoreapp/teacher/teacher.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({ Key? key }) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

FirebaseAuth _auth = FirebaseAuth.instance;

class _AnasayfaState extends State<Anasayfa> with TickerProviderStateMixin{
   GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  TextEditingController _usermail=TextEditingController();
  TextEditingController _userpass=TextEditingController();
  GlobalKey<FormState> _formkey2=GlobalKey<FormState>();
  TextEditingController _usermail2=TextEditingController();
  TextEditingController _userpass2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var tabcontroller=TabController(vsync: this,length: 2);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: tabcontroller,
          tabs: [
            Tab(
              child: Text("Öğrenci".toUpperCase(),style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text("Öğretmen".toUpperCase(),style: TextStyle(color: Colors.white),),
            ),
          ]
        ),
      ),
      body:TabBarView(
        controller: tabcontroller,
        children: [
          Container(
           child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Image(
                height: 200,
                width: MediaQuery.of(context).size.width-50,
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 5,),
            Divider(
              height: 0.5,
              color: Colors.grey,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [ 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      validator: (deger){
                        if(!EmailValidator.validate(deger)){
                          return "Geçerli mail giriniz";
                        }
                        else null;
                      },
                      controller: _usermail,
                      decoration: InputDecoration(
                        labelText: "Mail",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Loginfont"),
                        
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: true,
                      validator: (deger){
                        if(deger!.length<6){
                          return "Şifreniz en az 6 karakter olmalıdır";
                        }
                        else null;
                      },
                      controller: _userpass,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Loginfont"),
                        
                        border: OutlineInputBorder(                     
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            SizedBox(height: 5,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(175, 40),
                primary: Colors.teal.shade300,
              ),
              onPressed: _login, 
              child: Text("Giriş"),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 0.5,
              color: Colors.grey.shade200,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                  },
                  child: Text("Şifremi Unuttum"),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Kaydol()));
                  },
                  child: Text("Kaydol",style: TextStyle(decorationStyle: TextDecorationStyle.solid),),
                ),
              ],
            ),
          ],
        ),
          ),
          Container(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: Image(
                height: 200,
                width: MediaQuery.of(context).size.width-50,
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 5,),
            Divider(
              height: 0.5,
              color: Colors.grey,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formkey2,
              child: Column(
                children: [ 
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      validator: (deger){
                        if(!EmailValidator.validate(deger)){
                          return "Geçerli mail giriniz";
                        }
                        else null;
                      },
                      controller: _usermail2,
                      decoration: InputDecoration(
                        labelText: "Mail",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Loginfont"),
                        
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: true,
                      validator: (deger){
                        if(deger!.length<6){
                          return "Şifreniz en az 6 karakter olmalıdır";
                        }
                        else null;
                      },
                      controller: _userpass2,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Loginfont"),
                        
                        border: OutlineInputBorder(                     
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            SizedBox(height: 5,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(175, 40),
                primary: Colors.teal.shade300,
              ),
              onPressed: _login2, 
              child: Text("Giriş"),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 0.5,
              color: Colors.grey.shade200,
              indent: 40,
              endIndent: 40,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                  },
                  child: Text("Şifremi Unuttum"),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Kaydol()));
                  },
                  child: Text("Kaydol",style: TextStyle(decorationStyle: TextDecorationStyle.solid),),
                ),
              ],
            ),
            
          ],
        ),
          ),
        ]
      ),
    );
  }
  void _login() async{
    await Firebase.initializeApp();
    try{
      if(_formkey.currentState!.validate()){
      UserCredential _usercredential= await _auth.signInWithEmailAndPassword(email: _usermail.text, password: _userpass.text);
      User? _user=_usercredential.user;
      if(_user!.emailVerified){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Student()));
      }
      else{
        _auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: GestureDetector(
              child: Text("Maili Onaylayın Lütfen. ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            )
            ),
            backgroundColor: Colors.teal.shade300,
          ),
        );
      }
    }
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Mail adınız veya şifreniz yanlış",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Hata",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
    }
  }
  void _login2() async{
    await Firebase.initializeApp();
    try{
      if(_formkey2.currentState!.validate()){
      UserCredential _usercredential= await _auth.signInWithEmailAndPassword(email: _usermail2.text, password: _userpass2.text);
      User? _user=_usercredential.user;
      if(_user!.emailVerified){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Teacher()),);
      }
      else{
        _auth.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: GestureDetector(
              child: Text("Maili Onaylayın Lütfen. ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            )
            ),
            backgroundColor: Colors.teal.shade300,
          ),
        );
      }
    }
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Mail adınız veya şifreniz yanlış",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Hata"+e.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
    }
  }
}