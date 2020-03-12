import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
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

  getWebView(BuildContext context) {
//    Completer<WebViewController> _controller = Completer<WebViewController>();
    String url =
        "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/auth?scope=openid"
        "&response_type=code"
        "&redirect_uri=$redirect";
    String key = "smac-vn.com";
    String keyGetCode = "code=";
    String clientSecret = "8e67726d-c44e-49b8-9d8d-c6b21f3f8461";
    String clientId = "smac-vn.com";

    WebController _webController;
    FlutterNativeWeb flutterWebView;

    print(url);

    flutterWebView = new FlutterNativeWeb(
      onWebCreated: (webController) {
        _webController = webController;
        _webController.loadUrl(
            "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/auth?scope=openid"
            "&response_type=code"
            "&redirect_uri=http://smac-vn.com/mantisbt/login_page.php&client_id=smac-vn.com&kc_locale=vi&client_secret=8e67726d-c44e-49b8-9d8d-c6b21f3f8461");
        _webController.onPageStarted.listen(
          (url) async {
            if (url.substring(5, 20).contains(key)) {
              print("link direct: $url");
              Navigator.pop(context);

              String code = url.substring(url.indexOf(keyGetCode) + keyGetCode.length, url.length);
              print("code: $code");

              String requestToken =
                  "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/token";
              print("request: $requestToken");

              Map bodyToken = {
                "code": code,
                "grant_type": "authorization_code",
                "client_secret": clientSecret,
                "client_id": clientId,
                "redirect_uri": "http://smac-vn.com/mantisbt/login_page.php",
              };
              print("body token: $bodyToken");

              final http.Response responseToken = await http.post(
                requestToken,
                body: bodyToken,
              );
              print("response token: ${responseToken.body}");

              String token = jsonDecode(responseToken.body)['access_token'];

              String requestUser =
                  "https://postid.vnpost.vn/auth/realms/idp/protocol/openid-connect/userinfo";
              print("request token: $requestToken");

              Map<String, String> headerUser = {
                "Authorization": "Bearer $token",
                "cache-control": "no-cache",
              };
              print("body: $headerUser");

              final http.Response responseUser = await http.get(
                requestUser,
                headers: headerUser,
              );
              print("response user: ${utf8.decode(responseUser.bodyBytes)}");
            }
          },
        );
      },
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 400.0,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: flutterWebView,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
