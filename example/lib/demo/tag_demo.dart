import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jac_uikit/data_display.dart';

Widget space = const SizedBox(
  height: 30,
);

class TagDemo extends StatelessWidget {
  const TagDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("按钮示例")),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              space,
              Row(
                children: const [
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.gray,
                    text: "标签",
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.green,
                    text: "标签",
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.black,
                    text: "标签",
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.red,
                    text: "标签",
                    fontSize: 12,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  JacTag(
                    paddingVertical: 1,
                    paddingHorizontal: 6,
                    tagType: JacTagType.text,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.yellow,
                    text: "标签",
                    fontSize: 12,
                  ),
                ],
              ),
              space,
              Row(
                children: const [
                  SizedBox(
                    width: 30,
                  ),
                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.semicircle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.rectangle,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  JacTag(
                    paddingVertical: 5,
                    paddingHorizontal: 10,
                    tagType: JacTagType.icon,
                    tagShapeType: JacTagShapeType.capsule,
                    tagColorType: JacTagColorType.blue,
                    text: "标签",
                    icon: Icon(
                      Icons.ac_unit,
                      size: 14,
                      color: Color(0XFF5590F6),
                    ),
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
