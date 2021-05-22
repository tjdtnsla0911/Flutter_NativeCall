import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      print('IOS로 왔습니다');
      return CupertinoApp(

      );
    } else {
      print('Android에옴');
      return MaterialApp(
        title : 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NativeApp(),
      );
    }
  }
}

//# IOS통신
class CupertinoNativeApp extends StatefulWidget {
  const CupertinoNativeApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    print('Cupertino에옴');
    return null;
  }
}

// class _CupertinoNativeAppState extends State<CupertinoNativeApp> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }


class NativeApp extends StatefulWidget {
  const NativeApp({Key key}) : super(key: key);

  @override
  _NativeAppState createState() => _NativeAppState();
}

class _NativeAppState extends State<NativeApp> {

  static const platform = const MethodChannel('com.flutter.dev/info');
  String _deviceInfo = 'Unknown info';
  @override
  Widget build(BuildContext context) {
    print('platform = $platform');
    return Scaffold(

      appBar: AppBar(
        title: Text('Native 통신 에제'),
      ),

      body: Container(
        child: Center(
          child: Text(
            _deviceInfo,
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(

        onPressed: (){
          print('floatingActionButton Cick');
          _getDeviceInfo();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getDeviceInfo() async{
    print('_getDeviceInfo에옴');
    String deviceInfo;
    try{
      final String result = await platform.invokeMethod('getDeviceInfo');
      print('result = $result');
      deviceInfo = 'Device info : $result';
    }on PlatformException catch(e) {
      print('Excetion 발생');
      deviceInfo = 'Failed to get Device info : ${e.message}.';
    }

    setState(() {
      print('setState의 deviceInfo : $deviceInfo');
      _deviceInfo = deviceInfo;
    });
  }
}





