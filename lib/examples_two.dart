import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;

class exapale extends StatefulWidget {
  const exapale({super.key});

  @override
  State<exapale> createState() => _exapaleState();
}

class _exapaleState extends State<exapale> {
  List<photos> photosList=[];

  Future<List<photos>> getPhotos ()async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map i in data){
        photos Photos= photos(title: i['title'], url: i['url'],id: i['id']);
        photosList.add(Photos);
      } return photosList;
    }else{
     return photosList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
      Text('exampale'),),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(future: getPhotos(), builder: (context, AsyncSnapshot<List<photos>> snapshot){
                return ListView.builder(itemCount: photosList.length,
          itemBuilder: (context, index){
          return ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString()),),
            subtitle: Text(snapshot.data![index].id.toString()),
            title: Text(snapshot.data![index].title.toString()),);
                });
          }),
        ),
      ],),
    );
  }
}
class photos{
String title, url;
int id;
photos({required this.title, required this.url,required this.id});
}