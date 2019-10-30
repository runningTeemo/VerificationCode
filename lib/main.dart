import 'package:flutter/material.dart';
import 'package:pin_entry/QBCodeInputer.dart';
import 'package:pin_entry/pin_entry_text_field.dart';

import 'Options.dart';
import 'WGQVerCodeInputer.dart';

void main(){
  print("this is dart entrance");

  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> implements InputerProtocol{


  @override
  Widget build(BuildContext context) {

//    TextField findTextFieldByIndex(int index) {
//      Container tfContainer = tfs[index];
//      Padding padding = tfContainer.child;
//      Theme theme = padding.child;
//      GestureDetector gesture = theme.child;
//      Container container = gesture.child;
//      TextField tf = container.child;
//      return tf;
//    }
//


    Options opt = Options();
    opt.fontSize = 22.0;
    opt.fontColor = Colors.indigo;
    opt.fontWeight = FontWeight.w700;
    opt.emptyUnderLineColor = Colors.green;
    opt.inputedUnderLineColor = Colors.pink;
    opt.focusedColor = Colors.orange;
    //创建控件,并指明代理对象(delegate)
    WGQVerCodeInputer verCodeInputer = WGQVerCodeInputer(codeLength: 6, size: Size(200.0, 48.0), options:opt,delegate:this, );
    QBCodeInputer qbCodeInputer = QBCodeInputer(size: Size(200.0, 48.0));
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: verCodeInputer,
        )
    );


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
      return Scaffold(
      appBar: AppBar(
        title: Text("Pin Entry Example"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PinEntryTextField(
            showFieldAsBox: false,
            onSubmit: (String pin){

              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Pin"),
                      content: Text('Pin entered is $pin'),
                    );
                  }
              ); //end showDialog()

            }, // end onSubmit
          ), // end PinEntryTextField()
        ), // end Padding()
      ), // end Container()
    );
  }

  @override
  void didFinishedInputer(WGQVerCodeInputer inputer, BuildContext ctx, String verCode) {

    //判断验证码是否正确
//    bool correct = false;//(此处修改成你自己的判断逻辑)
//    if (!correct) {
//      inputer.reset();
//    }
    // TODO: implement didFinishedInputer
  }
}
