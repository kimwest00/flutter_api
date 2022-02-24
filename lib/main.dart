import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:host_please/User.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<UserModel?> createUser(int count, String status) async{
  const String apiUrl = "http://34.134.67.181:8080/api/subscribe/2";
  // Map<String,String> headers ={
  //   'Content-Type':'application/json',
  //   'Accept':'application/json',
  //   // 'Authorization': 1,
  // };
  final response = await http.post(apiUrl,headers: {HttpHeaders.authorizationHeader:'1'}

  ,body: (
      {
        "count": count,
        "status": status
      }
  ));
  print("hi;");
  print(response.statusCode);
  if(response.statusCode == 201){
    final String responseString = response.body;

    return userModelFromJson(responseString);
  }else{
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  UserModel? _user;

  final TextEditingController countController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[

            TextField(
              controller: countController,
            ),

            TextField(
              controller: statusController,
            ),

            SizedBox(height: 32,),

            _user == null ? Container() :
            Text("The user ${_user?.count}, ${_user?.status} is created successfully at time  "),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final int count = int.parse(countController.text);
          final String status = statusController.text;

          final UserModel? user = await createUser(count, status);

          setState(() {
            _user = user!;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}