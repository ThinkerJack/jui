import 'package:example/common/demo_base_page.dart';
import 'package:flutter/material.dart';
import 'package:jui/common.dart';

class DashedBorderContainerDemo extends DemoBasePage {
  const DashedBorderContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return super.builder("DashedBorderContainerDemo", [
      DashedBorderContainer(
        child: DashedBorderContainer(
          onTap: () {},
          dashColor: Colors.blue,
          dashWidth: 5,
          dashHeight: 5,
          dashSpace: 5,
          borderRadius: 10,
          child: const SizedBox(
            width: 100,
            height: 100,
          ),
        ),
      )
    ]);
  }
}
