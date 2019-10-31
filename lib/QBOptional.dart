/*
 * Created by Qianbao on 10/31/19 10:26 AM.
 * Last modified 10/31/19 10:26 AM.
 * Copyright (c) 2019. PING AN HEALTH CLOUD COMPANY LIMITED.
 * All rights reserved.
 */

import 'package:flutter/cupertino.dart';


class QBInputOptional {
  List<Widget> tfs;
  List<TextEditingController> tfCtrls;
  List<FocusNode> fns;
  List<String> valueStrs;
  int codeLength = 6;

  QBInputOptional(int codeLength) {
    this.codeLength = codeLength;
    tfCtrls = List.generate(this.codeLength, (index) {
      TextEditingController ctrl = TextEditingController();
      ctrl.addListener(() {
      });
      return ctrl;
    });
//
    this.fns = List.generate(codeLength, (index) {
      FocusNode fn = FocusNode();
      fn.addListener(() {});
      return fn;
    });

    this.valueStrs = List.generate(codeLength, (index) {
      return "";
    });

  }
}
