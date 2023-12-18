import "package:flutter/material.dart";

class ShowWidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? image;
  final Color color;

  const ShowWidget({
    super.key,
    required this.label,
    this.icon,
    this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          icon == null
              ? Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4.0,
                      color: color,
                    ),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: ClipOval(
                    child: Image.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Icon(icon, size: 64.0, color: color),
          const SizedBox(height: 16.0),
          FittedBox(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
