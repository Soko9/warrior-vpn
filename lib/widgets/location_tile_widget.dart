import "package:flutter/material.dart";
import "package:warrior_vpn/models/vpn_model.dart";

import "../utils/helpers.dart";

class LocationTileWidget extends StatelessWidget {
  final int index;
  final Vpn server;
  final VoidCallback onPress;

  const LocationTileWidget({
    super.key,
    required this.index,
    required this.server,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    return ListTile(
      onTap: onPress,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      title: Text(
        server.countryName.endsWith("of")
            ? server.countryName.substring(0, server.countryName.length - 3)
            : server.countryName,
      ),
      subtitle: Text(HELPERS.getBandwidthSpeedUnit(speed: server.speed)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(server.sessionNumber.toString()),
          const SizedBox(width: 4.0),
          Icon(
            Icons.people_alt_rounded,
            color: theme.colorScheme.tertiary,
          ),
        ],
      ),
      tileColor: index % 2 == 0
          ? theme.colorScheme.tertiaryContainer
          : theme.scaffoldBackgroundColor,
      leading: Container(
        width: size.width * 0.15,
        height: size.width * 0.15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2.0,
            color: theme.colorScheme.tertiary,
          ),
        ),
        padding: const EdgeInsets.all(6.0),
        child: ClipOval(
          child: Image.asset(
            "assets/flags/${server.countryCode.toLowerCase()}.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
