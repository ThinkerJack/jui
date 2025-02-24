import 'package:flutter/material.dart';
import 'package:jui/src/utils/screen_util.dart'; // 假设这里是 .w 的扩展方法所在
import '../utils/jui_theme.dart';

/// 定义按钮大小的枚举类型
enum JuiButtonSizeType {
  /// 大号按钮
  large,

  /// 中号按钮
  middle,

  /// 小号按钮
  small,

  /// 超小号按钮
  ultraSmall
}

/// 定义按钮颜色的枚举类型
enum JuiButtonColorType {
  /// 蓝色背景按钮
  blue,

  /// 灰色背景按钮
  gray,

  /// 白色背景按钮
  white,

  /// 蓝色边框按钮
  blueBorder
}

/// 按钮尺寸配置类
class JuiButtonSizeConfig {
  /// 按钮的高度
  final double height;

  /// 按钮字体大小
  final double fontSize;

  /// 按钮左右内边距
  final double padding;

  /// 创建一个按钮尺寸配置对象
  const JuiButtonSizeConfig({
    required this.height,
    required this.fontSize,
    required this.padding,
  });
}

/// 按钮颜色配置类
class JuiButtonColorConfig {
  /// 获取按钮背景颜色的函数，根据按钮是否禁用返回不同颜色
  final Color Function(bool disable) getColor;

  /// 获取按钮字体颜色的函数，根据按钮是否禁用返回不同颜色
  final Color Function(bool disable) getFontColor;

  /// 按钮边框，可选属性
  final BoxBorder? border;

  /// 创建一个按钮颜色配置对象
  const JuiButtonColorConfig({
    required this.getColor,
    required this.getFontColor,
    this.border,
  });
}

/// `JuiButton` 是一个可自定义颜色、大小等属性的按钮组件
///
/// 该组件支持不同的颜色、尺寸，并可配置是否可见、是否禁用等功能。
class JuiButton extends StatelessWidget {
  /// 按钮尺寸配置映射
  static final Map<JuiButtonSizeType, JuiButtonSizeConfig> _sizeConfig = {
    JuiButtonSizeType.large: JuiButtonSizeConfig(
      height: 48.w,
      fontSize: 16.w,
      padding: 32.w,
    ),
    JuiButtonSizeType.middle: JuiButtonSizeConfig(
      height: 40.w,
      fontSize: 14.w,
      padding: 24.w,
    ),
    JuiButtonSizeType.small: JuiButtonSizeConfig(
      height: 32.w,
      fontSize: 14.w,
      padding: 16.w,
    ),
    JuiButtonSizeType.ultraSmall: JuiButtonSizeConfig(
      height: 24.w,
      fontSize: 12.w,
      padding: 12.w,
    ),
  };

  /// 按钮颜色配置映射
  static Map<JuiButtonColorType, JuiButtonColorConfig> get _colorConfig => {
        JuiButtonColorType.white: JuiButtonColorConfig(
          getColor: (_) => JuiTheme.colors.surface,
          getFontColor: (disable) =>
              disable ? JuiTheme.colors.disabledLight : JuiTheme.colors.text,
          border: Border.all(color: JuiTheme.colors.divider, width: 1),
        ),
        JuiButtonColorType.gray: JuiButtonColorConfig(
          getColor: (_) => JuiTheme.colors.background,
          getFontColor: (disable) =>
              disable ? JuiTheme.colors.disabledLight : JuiTheme.colors.text,
        ),
        JuiButtonColorType.blue: JuiButtonColorConfig(
          getColor: (disable) =>
              disable ? JuiTheme.colors.lightBlue : JuiTheme.colors.primary,
          getFontColor: (_) => JuiTheme.colors.surface,
        ),
        JuiButtonColorType.blueBorder: JuiButtonColorConfig(
          getColor: (_) => JuiTheme.colors.surface,
          getFontColor: (_) => JuiTheme.colors.primary,
          border: Border.all(color: JuiTheme.colors.primary, width: 1),
        ),
      };

  /// 创建 `JuiButton` 按钮
  const JuiButton({
    Key? key,
    required this.colorType,
    required this.sizeType,
    required this.text,
    required this.onTap,
    this.visibility = true,
    this.width,
    this.fontSize,
    this.circular = 24,
    this.height,
    this.fontHeight = 1.0,
    this.disable = false,
    this.backGroundColor,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  /// 按钮点击时的回调函数
  final VoidCallback onTap;

  /// 按钮文本内容
  final String text;

  /// 按钮尺寸类型
  final JuiButtonSizeType sizeType;

  /// 按钮颜色类型
  final JuiButtonColorType colorType;

  /// 按钮是否可见
  final bool visibility;

  /// 按钮是否禁用
  final bool disable;

  /// 按钮的宽度（可选）
  final double? width;

  /// 按钮的高度（可选）
  final double? height;

  /// 按钮字体大小（可选）
  final double? fontSize;

  /// 按钮的圆角大小
  final double circular;

  /// 按钮文本的行高
  final double fontHeight;

  /// 按钮的背景颜色（可选）
  final Color? backGroundColor;

  /// 按钮文本的字体粗细
  final FontWeight fontWeight;

  /// 更新按钮的尺寸配置
  ///
  /// - [type]: 需要更新的按钮类型
  /// - [config]: 新的尺寸配置对象
  static void updateSizeConfig(
      JuiButtonSizeType type, JuiButtonSizeConfig config) {
    _sizeConfig[type] = config;
  }

  @override
  Widget build(BuildContext context) {
    if (!visibility) return const SizedBox.shrink();

    return InkWell(
      onTap: disable ? null : onTap,
      child: _buildButtonContainer(),
    );
  }

  /// 构建按钮的容器
  Widget _buildButtonContainer() {
    final sizeConfig = _sizeConfig[sizeType]!;
    final colorConfig = _colorConfig[colorType]!;

    final buttonContent = Container(
      height: height ?? sizeConfig.height,
      width: width,
      padding: width == null
          ? EdgeInsets.symmetric(horizontal: sizeConfig.padding)
          : null,
      decoration: BoxDecoration(
        color: backGroundColor ?? colorConfig.getColor(disable),
        borderRadius: BorderRadius.circular(circular),
        border: colorConfig.border,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: colorConfig.getFontColor(disable),
          fontSize: fontSize ?? sizeConfig.fontSize,
          height: fontHeight,
          fontWeight: fontWeight,
        ),
      ),
    );

    return width == double.infinity
        ? buttonContent
        : UnconstrainedBox(child: buttonContent);
  }
}
