import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/ui/widgets/card.dart';

class WANewsCard extends StatelessWidget {
  final String title, content, arch, level, payment;
  final VoidCallback onApply;

  // WANewsCard constructor
  const WANewsCard(
      {Key? key,
      required this.title,
      required this.content,
      required this.arch,
      required this.level,
      required this.payment,
      required this.onApply})
      : super(key: key);

  // We create a Stateless widget that contais an AppCard,
  // Passing all the customizable views as parameters
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).colorScheme.primary;
    return AppCard(
      key: const Key("offerCard"),
      title: title,
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      // topRightWidget widget as an IconButton
      topLeftWidget: SizedBox(
        height: 100.0,
        width: 100.0,
        child: Center(
          child: Image.asset("assets/images/vacuna.jpg"),
        ),
      ),
      topRightWidget: IconButton(
        icon: Icon(
          Icons.copy_outlined,
          color: primaryColor,
        ),
        onPressed: () {
          Clipboard.setData(ClipboardData(text: content));
          Get.showSnackbar(
            GetBar(
              message: "Se ha copiado la noticia al portapapeles.",
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
      // extraContent widget as a column that contains more details about the offer
      // and an extra action (onApply)
      extraContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.person,
                  color: primaryColor,
                ),
              ),
              Text(
                arch,
                style: Theme.of(context).textTheme.caption,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.date_range,
                  color: primaryColor,
                ),
              ),
              Text(
                '13/12/2021',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
