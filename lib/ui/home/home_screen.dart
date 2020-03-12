import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemologinother/bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc = HomeBloc();

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
                _homeBloc.getWebView(context);
              },
            ),
            RaisedButton(
              child: Text("Close webview"),
//              onPressed: () => flutterWebviewPlugin.close(),
            ),
//            Expanded(
//              flex: 1,
//              child: Container(
//                child: flutterWebView,
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
