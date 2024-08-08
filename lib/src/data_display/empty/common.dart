import 'package:flutter/cupertino.dart';
import 'package:habit/dependencies.dart';

Text noDataText(String emptyText) {
  return Text(
    emptyText,
    style: TextStyle(color: const Color(0XFF858B9B), fontWeight: FontWeight.w500, fontSize: 16.r, height: 1.5),
  );
}
