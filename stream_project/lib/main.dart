import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class  MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int initCount = 10;
    LikeCounter counter = LikeCounter([initCount, 0]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Reactive Programming Demo'),
      ),
      body: Center(
        child: StreamBuilder<dynamic>(
            stream: counter.outControl,
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, int) {
                    return Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => counter.addClick.add([10, int]),
                          child: Image.asset("./mqdefault.jpg"),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
                          child: Text(
                              "like it ${snapshot.data == null ? 0 : snapshot.data[int]}"),
                        )
                      ],
                    );
                  });
            }),
      ),
    );
  }
}

class LikeCounter {
  List<dynamic> _counter;

  var _counterController = StreamController();
  StreamSink get _addControll => _counterController.sink;
  Stream get outControl => _counterController.stream;

  var _clickController = StreamController();

  StreamSink get addClick => _clickController.sink;
  LikeCounter(val) {
    _counter = _counter = List.generate(val[0], (i) => 0);
    _clickController.stream.listen(_handle);
  }

  void dispose() {
    _counterController.close();
    _clickController.close();
  }

  void _handle(data) {
    _counter[data[1]] = _counter[data[1]] + 1;
    _addControll.add(_counter);
  }
}
