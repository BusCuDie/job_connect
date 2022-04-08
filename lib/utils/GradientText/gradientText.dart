import "package:flutter/material.dart";

class GradientText extends StatelessWidget {
  final text;
  final TextStyle? style;
  final Gradient gradient;
  const GradientText(this.text, {required this.gradient, this.style});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => gradient
          .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
