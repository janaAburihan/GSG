import 'package:flutter/material.dart';
import '../../models/link.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({super.key, required this.link});
  final Link link;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            link.description,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            link.url,
            style: const TextStyle(
                fontSize: 16, color: Colors.blue, letterSpacing: 0.5),
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
