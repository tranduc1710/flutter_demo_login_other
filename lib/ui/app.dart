import 'package:flutter/material.dart';

import 'home/home_screen.dart';

class MyApp extends StatelessWidget {
  String url =
      'https://www.google.com/search?newwindow=1&safe=active&sxsrf=ALeKk03MA_hW-eiGf9T97nKItOmg'
      '9flcTg%3A1583808062390&source=hp&ei=Pv5mXo34FY38wAOs_J7YBw&q=sso+redhat&oq=ss&gs_l=psy-ab.3.0'
      '.35i39i19j35i39l2j0i131l2j0l5.710.918..1819...1.0..0.111.210.1j1......0....1..gws-'
      'wiz.lG5H1AaCYFM';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.fallback(),
      home: HomeScreen(),
      routes: {
        'HomeScreen': (context) => HomeScreen(),
      },
    );
  }
}
