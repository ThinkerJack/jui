import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ItemDivider extends StatelessWidget {
  const ItemDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0XFFE8EAEF),
      height: 1,
    );
  }
}
