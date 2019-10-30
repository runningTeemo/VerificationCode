import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QBCodeInputer extends StatefulWidget {
  int codeLength = 6;
  final Size size;
  double gap = 2.0;

  QBCodeInputer({this.size});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputState();
  }
}

class _InputState extends State<QBCodeInputer> {
  List<Widget> tfs;
  List<TextEditingController> tfCtrls;
  List<FocusNode> fns;
  List<String> oldStrs;

  @override
  Widget build(BuildContext context) {
    ///获取index对应的tf
    TextField findTextFieldByIndex(int index) {
      Container tfContainer = tfs[index];
      Padding padding = tfContainer.child;
      Theme theme = padding.child;
      GestureDetector gesture = theme.child;
      Container container = gesture.child;
      TextField tf = container.child;
      return tf;
    }

    tfCtrls = List.generate(widget.codeLength, (index) {
      TextEditingController ctrl = TextEditingController();
      ctrl.addListener(() {});
      return ctrl;
    });
    fns = List.generate(widget.codeLength, (index) {
      FocusNode fn = FocusNode();
      return fn;
    });

    tfs = List.generate(widget.codeLength, (index) {
      FocusNode fc = fns[index];
      fc.addListener(() {
//        focused(index);
      });

      oldStrs = List.generate(widget.codeLength, (index) {
        return "";
      });

      _handleChange(String text, int index) {
        var oldStr = oldStrs[index];

        if (oldStr.length == 0 &&
            index < widget.codeLength - 1 &&
            text.length > 0) {
          oldStrs[index] = text;
//          FocusNode oldfc = fns[index];
//          oldfc.unfocus();
          FocusNode fc = fns[index + 1];
          fc.requestFocus();
        } else if (text.length == 0 && index > 0) {
          oldStrs[index] = "";
          FocusNode fc = fns[index - 1];
          fc.requestFocus();
        }
      }

      TextEditingController ctrl = tfCtrls[index];
//      Color borderColor = (ctrl.text.isEmpty || ctrl.text == '●')
//          ? opt.emptyUnderLineColor
//          : opt.inputedUnderLineColor;
//      Color textColor = (ctrl.text.isEmpty || ctrl.text == '●')
//          ? Colors.transparent
//          : opt.fontColor;

//      if (fc.hasFocus) {
//        borderColor = Colors.blue;
//      }

      ///获取当前皮肤
      final ThemeData base = Theme.of(context);

      ThemeData buildDarkTheme() {
        return base.copyWith(
          textSelectionColor: Colors.transparent,
          secondaryHeaderColor: Colors.transparent,
          accentColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            disabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.black12)),
          ),
        );
      }

      return Container(
        width: (widget.size.width / widget.codeLength),
        child: Padding(
          padding: EdgeInsets.all(widget.gap),
          child: Theme(
            data: buildDarkTheme(),
            child: GestureDetector(
              onTap: () {
//								setFocusedTextFiled(index);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                child: TextField(
                  controller: ctrl,
                  key: Key(index.toString()),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  cursorColor: Colors.transparent,
                  cursorWidth: 1,
                  enabled: false,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    counterText: "",
                  ),
                  onChanged: (String text) {
                    _handleChange(text, index);
                  },
                  autofocus: index == 0,
                  focusNode: fns[index],
                ),
              ),
            ),
          ),
        ),
      );
    });

    /*build 要渲染的页面*/
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: tfs,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
