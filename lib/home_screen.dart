import 'dart:convert';

import 'package:apis/models/posts_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<PostsModel> postList =[];
  
  

  Future<List<PostsModel>> getPostApi ()async{
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
   var data = jsonDecode(response.body.toString());
   if(response.statusCode == 200){
    postList.clear();
    for(Map i in data){
    postList.add(PostsModel.fromJson(i));
    
    }
    return postList;
   }else{
    return postList;

   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('api course'),),
      body: 
      Column(
        children: [
        Expanded(
          child: FutureBuilder(future: getPostApi(),  builder: (context, snapshot){
                 if(!snapshot.hasData){
                return Text('loading');
                 }else{
                return ListView.builder(itemCount: postList.length,
          itemBuilder: (context, index){
          return Card(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text(postList[index].title.toString()),

               Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text(postList[index].body.toString()),
              ],
            ),
          ),);
                });
                 }
          }),
        ),
        ],
      ),
    );
  }
}