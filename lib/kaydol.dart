import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class Kaydol extends StatefulWidget {
  const Kaydol({ Key? key }) : super(key: key);

  @override
  State<Kaydol> createState() => _KaydolState();
}
FirebaseAuth _authkaydol = FirebaseAuth.instance;
class _KaydolState extends State<Kaydol> {
  GlobalKey<FormState> _formkey3=GlobalKey<FormState>();
  TextEditingController _usermail3=TextEditingController();
  TextEditingController _userpass3=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Form(
              key: _formkey3,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: Image(
                      height: 200,
                      width: MediaQuery.of(context).size.width-50,
                      image: AssetImage("assets/images/register.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 5,),
                  const Divider(
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
                      controller: _usermail3,
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
                      controller: _userpass3,
                      decoration: InputDecoration(
                        labelText: "Şifre",
                        labelStyle: const TextStyle(color: Colors.teal,fontSize: 14, fontWeight: FontWeight.w200, fontFamily: "Loginfont"),
                        
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(175, 40),
                    primary: Colors.teal.shade300,
                  ),
                  onPressed: _register, 
                  child: Text("Kaydol"),
                ),
                
              ],
            )
          ],
        )
      ),


    );
  }
  void _register() async{
      await Firebase.initializeApp();
      try{
      if(_formkey3.currentState!.validate()){
      UserCredential _usercredential=await _authkaydol.createUserWithEmailAndPassword(email: _usermail3.text, password: _userpass3.text);
      User? _user=_usercredential.user;
      await _user!.sendEmailVerification();
      if(_authkaydol.currentUser!=null){
        await _authkaydol.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3,),
            behavior: SnackBarBehavior.floating,
            content: Text("Üyelik İşleminiz Tamamlanmıştır.\nMaili Onayladıktan Sonra Giriş Yapabilirsiniz",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
      Navigator.pop(context);
      }
        }
      }
      on FirebaseAuthException catch(e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3,),
            behavior: SnackBarBehavior.floating,
            content: Text("Kullanıcı Kaydınız Var Lütfen Farklı Bir Hesap Dene",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            backgroundColor: Colors.teal.shade300,
          ),
      );
      Navigator.pop(context);
      }
      catch(e){
        print("Hata"+e.toString());
      }
      

    
    
  }
}