import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({ Key? key }) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

FirebaseAuth _authforget = FirebaseAuth.instance;

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> _formkeyforget=GlobalKey<FormState>();
  TextEditingController _usermailforget=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formkeyforget,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Image(
                      height: 200,
                      width: MediaQuery.of(context).size.width-50,
                      image: const AssetImage("assets/images/forgetp.png"),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      validator: (deger){
                        if(!EmailValidator.validate(deger)){
                          return "Geçerli mail giriniz";
                        }
                        else null;
                      },
                      controller: _usermailforget,
                      decoration: InputDecoration(
                        labelText: "Mail",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.w200, fontFamily: "Loginfont"),
                        
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  SizedBox(height: 5,),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(175, 40),
                    primary: Colors.teal.shade300,
                  ),
                  onPressed: _forgetpassword, 
                  child: Text("Gönder"),
                ),
               
                
              ],
            )
          ],
        )
      ),
    );
  }

  void _forgetpassword() async{
    await Firebase.initializeApp();
    try{ 
    if(_formkeyforget.currentState!.validate()){
      _authforget.sendPasswordResetEmail(email: _usermailforget.text);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            content: Text("Şifre Güncelleme Linki Gönderilmiştir.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
      Navigator.pop(context);
      }
    }
    catch(e){
      print("Hata"+e.toString());
    }
  }
}