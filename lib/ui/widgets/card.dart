import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget? topLeftWidget, topRightWidget, content, extraContent;
  final String? title;

  // AppCard constructor
  const AppCard(
      {Key? key,
      //required this.title,
      this.title,
      this.content,
      this.topLeftWidget,
      this.topRightWidget,
      this.extraContent})
      : super(
          key: key,
        );

  // Building basic card style
  // With the option to modify its content
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.only(
            top: 4.0, bottom: 16.0, left: 8.0, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                topLeftWidget != null
                    ? topLeftWidget!
                    : const SizedBox(
                        width: 48.0,
                      ),
                title != null
                  ? Expanded(
                    child: Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ))
                  : const SizedBox(
                        width: 48.0,
                      ),
                topRightWidget != null
                    ? topRightWidget!
                    : const SizedBox(
                        width: 48.0,
                      ),
              ],
            ),
            const SizedBox(
              height: 6.0,
            ),
            if (content != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: content,
              ),
            if (extraContent != null)
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: extraContent,
              ),
          ],
        ),
      ),
    );
  }
}
