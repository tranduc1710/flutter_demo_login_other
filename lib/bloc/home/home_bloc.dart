import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;

class HomeBloc {
  StreamController _token = StreamController();

  Stream get token => _token.stream;

  String redirect =
      "http://smac-vn.com/mantisbt/login_page.php&client_id=smac-vn.com&kc_locale=vi&client_secret=8e67726d-c44e-49b8-9d8d-c6b21f3f8461";

  dispose() {
    _token.close();
  }

  getToken(String name) => _token.sink.add(name);

  getWebView({String appId, String appSecret, FlutterWebviewPlugin flutterWebviewPlugin}) {
    String url =
        "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/auth?scope=openid"
        "&response_type=code"
        "&redirect_uri=$redirect";

    flutterWebviewPlugin.launch(
      url,
      clearCache: false,
      clearCookies: false,
      rect: new Rect.fromLTWH(
        0.0,
        50.0,
        500.0,
        400.0,
      ),
    );

    String key = "smac-vn.com";

    String keyGetCode = "code=";

    String clientSecret = "8e67726d-c44e-49b8-9d8d-c6b21f3f8461";
    String clientId = "smac-vn.com";

    flutterWebviewPlugin.onUrlChanged.listen(
      (String url) async {
        if (url.substring(5, 20).contains(key)) {
          print("link direct: $url");
          flutterWebviewPlugin.close();

          String code = url.substring(url.indexOf(keyGetCode) + keyGetCode.length, url.length);
          String request = "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/token";
          print("request: $request");

          Map body = {
            "code": code,
            "grant_type": "authorization_code",
            "client_secret": clientSecret,
            "client_id": clientId,
            "redirect_uri": "http://smac-vn.com/mantisbt/login_page.php",
          };
          print("body: $body");

          final http.Response response = await http.post(
            request,
            body: body,
          );
          print("response: ${response.body}");

          getToken("response: ${response.body}");
        }
      },
    );
  }
}
