import "package:flutter/material.dart";

class VPNButtonWidget extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onPress;

  const VPNButtonWidget({
    super.key,
    required this.color,
    required this.child,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPress,
      borderRadius: BorderRadius.circular(size.width * 0.6),
      splashColor: color,
      hoverColor: Colors.transparent,
      highlightColor: color,
      child: CircleAvatar(
        radius: size.width * 0.3,
        backgroundColor: color.withOpacity(0.3),
        child: CircleAvatar(
          radius: size.width * 0.25,
          backgroundColor: color.withOpacity(0.7),
          child: CircleAvatar(
            radius: size.width * 0.2,
            backgroundColor: color,
            child: Center(
              child: child is Text
                  ? FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: child,
                      ),
                    )
                  : child,
            ),
          ),
        ),
      ),
    );
  }
}
