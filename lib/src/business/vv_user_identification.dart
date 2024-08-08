import 'package:flutter/material.dart';
import 'package:vv_ui_kit/src/business/non_vv_user_page.dart';
import 'package:vv_ui_kit/src/business/vv_user_page.dart';

///Author:Jason
///Date:2024-04-08 22:00
///Desc:封装VV用户标识组件
class VVUserIdentificationPage extends StatelessWidget {
  // 区分是否是微微认证用户,默认是微微用户,认证用户请传递true
  bool? vvAuthentication;

  // 区分是否是微微用户,默认显示微微用户,非微微请传参数false
  bool? isVVUser;

  VVUserIdentificationPage({super.key, this.vvAuthentication = false, this.isVVUser = true});

  @override
  Widget build(BuildContext context) {
    if (isVVUser == false) {
      return const NonVVUserPage();
    }
    return const VVUserPage();
  }
}
