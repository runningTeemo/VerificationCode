/*
 * Created by Qianbao on 10/30/19 9:11 PM.
 * Last modified 10/30/19 9:11 PM.
 * Copyright (c) 2019. PING AN HEALTH CLOUD COMPANY LIMITED.
 * All rights reserved.
 */

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'QBOptional.dart';



typedef FinishInput = void Function(String verCoder);
abstract class QBInputerProtocol {
  void didFinishedInputer( String verCode);
  void textFieldBecameFocus(FocusNode focusNode);
}

class QBCodeInputer extends StatefulWidget {
  int codeLength = 6;
  final Size size;
  double gap = 10.0;
  final QBInputOptional codeInputOptional;
  QBCodeInputer({this.size, this.delegate,@required this.codeInputOptional});
  QBInputerProtocol delegate;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputState();
  }
}

class _InputState extends State<QBCodeInputer> {

  @override
  Widget build(BuildContext context) {
    final List<Widget> tfs = List.generate(widget.codeLength, (index) {
      FocusNode fc = this.widget.codeInputOptional.fns[index];
      fc.addListener(() {

      });

      TextEditingController ctrl = this.widget.codeInputOptional.tfCtrls[index];

      ///获取当前皮肤
      final ThemeData base = Theme.of(context);

      ThemeData buildDarkTheme() {
        return base.copyWith(
          textSelectionColor: Colors.transparent,
          secondaryHeaderColor: Colors.transparent,
          accentColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            disabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Color(0xffD8D8D8))),
          ),
        );
      }
      //获取当前的vercode
      String _getAllVerificationCode() {
        String allVerificationCode = "";
        for( String str in this.widget.codeInputOptional.valueStrs) {
          if(str.length > 0) {
            allVerificationCode += str.replaceAll(" ", "");
          }
        }
        return allVerificationCode;
      }
//聚焦
      _focuse(index) {
        for (FocusNode focusNode in this.widget.codeInputOptional.fns) {
          focusNode.unfocus();
        }
        FocusNode fc = this.widget.codeInputOptional.fns[index];
        fc.requestFocus();
        this.widget.delegate.textFieldBecameFocus(fc);
        TextEditingController ctrl = this.widget.codeInputOptional.tfCtrls[index];
        ctrl.text = " ";
        this.widget.codeInputOptional.valueStrs[index] = "";
      }
      //取消焦点
      _unfocus(index) {
        FocusNode fc = this.widget.codeInputOptional.fns[index];
        fc.unfocus();
        if(index == this.widget.codeLength) {
          this.widget.delegate.didFinishedInputer(_getAllVerificationCode());
        }
      }

      //处理change变化
      _handleChange(String text, int index) {

        if (text.length > 0 && text != " ") {
          this.widget.codeInputOptional.valueStrs[index] = text.replaceAll(" ", "");
          //下一个聚焦
          if (index < 5) {
            _focuse(index+1);
            //为了实现回退
            TextEditingController ctrl = this.widget.codeInputOptional.tfCtrls[index+1];
            ctrl.text = " ";
//            ctrl.selection = TextSelection(baseOffset: -1, affinity: TextAffinity.downstream, extentOffset: ctrl.text.length - 1);
          } else {
            _unfocus(index);
            this.widget.delegate.didFinishedInputer(_getAllVerificationCode());
          }
        } else {//回退
          if (text.length == 0) {
            //下一个聚焦
            TextEditingController ctrl = this.widget.codeInputOptional.tfCtrls[index-1];
            ctrl.selection = TextSelection(baseOffset: -1, affinity: TextAffinity.downstream, extentOffset: ctrl.text.length - 1);
            ctrl.text = ' ';
            _focuse(index-1);
            this.widget.codeInputOptional.valueStrs[index-1] = "";
          }
        }
      }

      return GestureDetector(
        onTap: (){
          int currentLength = _getAllVerificationCode().length;
          if(currentLength > 0) {
            currentLength != this.widget.codeLength ? _focuse(currentLength) :
            _focuse(this.widget.codeLength - 1);
          } else {
            _focuse(0);
          }
        },
        child: Container(
          color: Color(0xFFFFFF),
          width: (widget.size.width / widget.codeLength),
          padding: EdgeInsets.all(widget.gap),
          child: Theme(
            data: buildDarkTheme(),
            child:  TextField(
              controller: ctrl,
              key: Key(index.toString()),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
//              cursorColor: Colors.transparent,
              cursorWidth: 1,
              enabled: false,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xff333333),
              ),
              decoration: InputDecoration(
                counterText: "",
              ),
              onChanged: (String text) {
                _handleChange(text, index);
              },
              autofocus: false,
              focusNode: this.widget.codeInputOptional.fns[index],
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
