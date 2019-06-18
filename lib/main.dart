import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _webviewHeight = 500;
  bool _pageFinished = false;
  bool _webviewCreated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            title: Text(_webviewCreated
                ? 'WebView created - ${_webviewHeight.floor()}'
                : 'Preparing'),
            backgroundColor: _pageFinished ? Colors.green : Colors.amber,
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(border: Border.all()),
              child: Text(
                'Text before webView',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              height:
                  math.max(MediaQuery.of(context).size.height, _webviewHeight),
              child: WebView(
                initialUrl:
                    'https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html',
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (String url) {
                  print('[webView/onPageFinished] finished loading "$url"');
                  setState(() {
                    _pageFinished = true;
                  });
                },
                onWebViewCreated: (WebViewController ctrl) {
                  print('[webView/onWebViewCreated] created');
                  setState(() {
                    _webviewCreated = true;
                  });
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DecoratedBox(
              decoration: BoxDecoration(border: Border.all()),
              child: Text(
                'Text after webView',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _webviewHeight += 500;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
