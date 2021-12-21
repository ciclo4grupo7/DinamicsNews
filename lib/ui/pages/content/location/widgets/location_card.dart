import 'package:flutter/material.dart';
import 'package:dynamics_news/ui/widgets/card.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCard extends StatelessWidget {
  final String title;
  final double lat, long;
  final double? distance;
  final VoidCallback? onUpdate;

  // PostCard constructor
  const LocationCard(
      {Key? key,
      required this.title,
      this.lat = 0,
      this.long = 0,
      this.distance,
      this.onUpdate})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("locationCard"),
      title: title,
      // topLeftWidget widget as an Icon
      topLeftWidget: IconButton(
        icon: Icon(
          onUpdate != null
              ? Icons.my_location_outlined
              : Icons.near_me_outlined,
          color: primaryColor,
        ),
        onPressed: () async {
          if (onUpdate != null) {
            final url = "https://www.google.es/maps?q=$lat,$long";
            await launch(url);
          }
        },
      ),
      // topRightWidget widget as an IconButton or null

      topRightWidget: onUpdate != null
          ? IconButton(
              icon: Icon(
                Icons.sync_outlined,
                color: primaryColor,
              ),
              onPressed: onUpdate,
            )
          : null,
      content: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lat != 0)
              Text(
                'Latitud:',
                style: Theme.of(context).textTheme.headline3,
              ),
              if (long != 0)
              Text(
                'Longitud:',
                style: Theme.of(context).textTheme.headline3,
              ),
              if (distance != null)
                Text(
                  'Distancia:',
                  style: Theme.of(context).textTheme.headline3,
                ),
            ],
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (lat != 0)
                Text(
                  '$lat',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              if (long != 0)
                Text(
                  '$long',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              if (distance != null)
                Text(
                  '$distance Km',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
            ],
          ))
        ],
      ),
    );
  }
}
