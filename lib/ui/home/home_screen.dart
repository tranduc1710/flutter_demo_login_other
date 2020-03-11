import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutterdemologinother/bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  HomeBloc _homeBloc = HomeBloc();

  String facebookAppId = "515137249145646";
  String facebookAppSecret = "26205b69c6a3ee5c5f2c8c1dea5abda1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home screen"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<Object>(
                stream: _homeBloc.token,
                builder: (context, snapshot) {
                  return Text("${snapshot.data}");
                }),
            RaisedButton(
              child: Text("Open webview"),
              onPressed: () async {
                _homeBloc.getWebView(
                  appId: facebookAppId,
                  appSecret: facebookAppSecret,
                  flutterWebviewPlugin: flutterWebviewPlugin,
                );
              },
            ),
            RaisedButton(
              child: Text("Close webview"),
              onPressed: () => flutterWebviewPlugin.close(),
            ),
          ],
        ),
      ),
    );
  }
}
