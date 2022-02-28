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

Future<Welcome?> createUser(int price, String date, String f_name) async{
  const String apiUrl = "http://34.134.67.181:8080/api/donation";
  var responsebody = jsonEncode({
    "donationDate": date,
    "donationPrice": price,
    "f_name": f_name
  });

  final response = await http.post(Uri.parse(apiUrl),headers: {HttpHeaders.authorizationHeader:'1'
  ,"Accept": "application/json",
    "Access-Control-Allow-Origin": "*"}
      ,body:
      responsebody
  );

  print(response.statusCode);

  if(response.statusCode == 200){
    final String responseString = response.body;
    return welcomeFromJson(responseString);
  }else{
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  Welcome? _welcome;
  final TextEditingController f_nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

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
              controller: f_nameController,
            ),

            TextField(
              controller: priceController,
            ),
            TextField(
              controller: dateController,
            ),

            SizedBox(height: 32,),

            _welcome == null ? Container() :
            Text("The user ${_welcome?.donationPrice}, ${_welcome?.donationDate} is created successfully at time  "),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String f_name = f_nameController.text;
          final int price = int.parse(priceController.text);
          final String date = dateController.text;
          final Welcome? welcome = await createUser(price,date, f_name);


          setState(() {
            _welcome = welcome!;
          });
          print(_welcome?.donationPrice);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}