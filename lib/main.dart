import 'dart:async';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new wp(cameras),
    );
  }
}

class wp extends StatefulWidget {
  var cameras;
  wp(this.cameras);
  @override
  _wpState createState() => _wpState();
}

class _wpState extends State<wp> with SingleTickerProviderStateMixin {
  TabController whatsappController;

  @override
  void initState() {
    whatsappController = TabController(initialIndex: 1, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp'),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.more_vert),
          )
        ],
        bottom: TabBar(
            indicatorColor: Colors.white,
            controller: whatsappController,
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: 'Chats',
              ),
              Tab(
                text: 'Status',
              ),
              Tab(
                text: 'Calls',
              ),
            ]),
        backgroundColor: Color(0xff075E54),
      ),
      body: TabBarView(controller: whatsappController, children: [
        //camera
        new CameraScreen(widget.cameras),

        ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('Best Friend'),
                  subtitle: Text('Hello Rahul!'),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://amppob.com/wp-content/uploads/2015/10/jobs.jpg'),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[Text('10:00 AM')],
                  ));
            }),
        //status
        ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Best Friend'),
                subtitle: Text('Today, 6:52 AM'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'http://amppob.com/wp-content/uploads/2015/10/jobs.jpg'),
                ),
              );
            }),
        //calls
        ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text('Best Friend'),
                  subtitle: Row(children: <Widget>[
                    Icon(
                      Icons.call_received,
                      size: 15.0,
                      color: Colors.red,
                      textDirection: TextDirection.ltr,
                    ),
                    Text('August 7, 10:30 AM')
                  ]),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://amppob.com/wp-content/uploads/2015/10/jobs.jpg'),
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.call,
                        color: Color(0xff075E54),
                      )
                    ],
                  ));
            }),
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}

class CameraScreen extends StatefulWidget {
  List<CameraDescription> cameras;
  CameraScreen(this.cameras);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new CameraController(widget.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      // aspectRatio: controller.value.aspectRatio,
      aspectRatio: 100.0,
      child: new CameraPreview(controller),
    );
//  return new CameraPreview(controller);
  }
}
