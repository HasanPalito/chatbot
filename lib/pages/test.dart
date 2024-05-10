
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'server_reply_class.dart';
class test extends StatefulWidget{
  const test({super.key});

  @override
  State<test> createState() => _testpage();
}


// class of reply
class _testpage extends State<test> {
  //variable
  String reply = "hello";
  final player = AudioPlayer();
  final _url  = "http://localhost:1337/v1/chat/completions";
  final myController = TextEditingController();
  String bottom_text_field= "";

  //function
  void play_audio(){
    setState(() {
      player.play(AssetSource('miaw gojo.mp3'));
    });
  }
  void pause(){
    setState(() {
      player.pause();
    });
  }
  void test_post()async{
    var response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    body: {
      "id":1.toString(),
      "name": "acumalaka",
    }
    );
    print(response.body);
  }
  
  
  void fetch_response() async{
    print("hiiii");
    try {
      var response = await http.post(
          Uri.parse("http://192.168.1.16:1337/v1/chat/completions"),
          headers: {
            "accept":  "application/json",
            "Content-Type": "application/json"
          },
          body : jsonEncode(
              {
            "model": "llama2-7b",
            "messages": [
              {"role": "user", "content": "$bottom_text_field (pretend to be my girlfriend, and dont use emoji,) "}
            ]
          })
      );
      print("hiiii");
      ServerReply jawaban = ServerReply.fromJson(jsonDecode(response.body));
      reply= jawaban.choices[0].message.content;
      setState(() {
        reply= jawaban.choices[0].message.content;
      });
      print("hiiii");
      myController.clear();
    }
    catch(e){
      print('hello');
      print(e);
    }
  }
  //ui thing
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 176, 208, 247),
      appBar: AppBar(
        title: const Text("acumalaka",),
        centerTitle: true,
        backgroundColor: Colors.blue[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
          )
        ),
      ),
      body:
        Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:const EdgeInsets.only(top:32) ,
              child: CircleAvatar(
                radius: 50,
                backgroundImage : AssetImage(
                "assets/apalahpakcik.jpg",
                 ),)
                )
            ,

              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32
                ),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                  children: [
                    IconButton(
                      icon: Icon(Icons.play_circle) ,
                      onPressed: play_audio,
                    ),
                    IconButton(
                      icon: Icon(Icons.pause_circle),
                      onPressed: pause,
                    ),

                  ],
                ),
              ),

            SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(left:32,right:32,bottom: 32),
                    child: Container(
                      alignment: Alignment.topRight,
                      decoration:BoxDecoration(
                      color: Color.fromARGB(255, 149, 158, 252),
                      shape: BoxShape.rectangle,
                      border: Border.all(
                      color: Color.fromARGB(255, 149, 158, 252),
                      width: 10,
                      ), borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                      child: Text(
                        bottom_text_field,
                        textAlign: TextAlign.right,
                        maxLines: 10,
                        overflow: TextOverflow.fade,
                      ),
                    )))),
            Expanded(
                child: SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(left:32,right:80),
                      child: Container(
                          decoration:BoxDecoration(
                            color: Color.fromARGB(255, 212, 228, 255),
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 212, 228, 255),
                              width: 10,

                            ),
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          ),
                          child:Text(
                              reply,
                              maxLines: 10,
                              overflow: TextOverflow.fade,
                          )
                      ),

                    )
                  )
                )
            ),
          Container(
            padding: EdgeInsets.only(left:20,bottom: 10,top: 5,right: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          // First child is enter comment text input
            Expanded(
              child: TextFormField(
                controller: myController,
                onChanged: (val){
                  bottom_text_field= val;
                },
                autocorrect: false,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                  fillColor: Colors.blue,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.purpleAccent)),
                ),
              ),
            ),
          // Second child is button
             IconButton (
                icon: Icon(Icons.send),
                iconSize: 20.0,
                onPressed:fetch_response
              )
          ],
        ),
      ),

    ])));
  }
}