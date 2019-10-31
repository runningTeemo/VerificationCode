import 'package:flutter/material.dart';
import 'package:pin_entry/QBCodeInputer.dart';
import 'package:pin_entry/QBOptional.dart';


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

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  FocusNode currentFocusNode;
  final QBInputOptional codeInputOptional = QBInputOptional(6);

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

class _MyHomePageState extends State<MyHomePage> implements QBInputerProtocol{


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

    QBCodeInputer qbCodeInputer = QBCodeInputer(size: Size(300.0, 48.0),
      codeInputOptional: this.widget.codeInputOptional,delegate: this,);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: GestureDetector (
          onTap: (){
            this.widget.currentFocusNode.unfocus();
          },
          child: Container(
            height: 500,
            color: Colors.red,
            alignment: Alignment.center,
            child: qbCodeInputer,
          ),
        ),
    );

  }

  @override
  void didFinishedInputer( String verCode) {
    //输入完成 回调
  }


  @override
  void textFieldBecameFocus(FocusNode focusNode) {

    this.widget.currentFocusNode = focusNode;
  }



}
