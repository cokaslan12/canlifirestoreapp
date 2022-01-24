
import 'package:canlifirestoreapp/data_model/yoklama.dart';
import 'package:canlifirestoreapp/respo_data/yoklama_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Teacher extends StatefulWidget {
  const Teacher({ Key? key }) : super(key: key);

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  @override
  Widget build(BuildContext context) {
    var _getyoklamapi=Provider.of<YoklamaApi>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Bugün Derse Katılanlar"),
      ),
      body: FutureBuilder<List<Yoklama>>(
        builder: (BuildContext context,snapshot){
          if(snapshot.hasData){
            
            List<Yoklama> gelenyoklama=snapshot.data!;
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(
                title: Text(gelenyoklama[index].numaras.toString()),
                subtitle: Text(gelenyoklama[index].name+" "+gelenyoklama[index].surname),
                leading: CircleAvatar(
                  child: Text(""),
                  backgroundColor: Colors.green.shade500,
                ),
              );
            },itemCount: gelenyoklama.length,);
          }
          else if(snapshot.hasError){
            return Center(
              child: Text("Bugün Ders Yok"),
            );
          }
          else{
            return Center(
              child: Text("Bugün Ders Yok"),
            );
          }
        },
        future: _getyoklamapi.fetchdata(),
      ),
    );
  }
}