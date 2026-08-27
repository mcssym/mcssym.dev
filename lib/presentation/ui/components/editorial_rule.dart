import 'package:flutter/material.dart';

class EditorialRule extends StatelessWidget {
  final bool double;

  const EditorialRule({super.key, this.double = false});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).dividerColor;
    if (!double) return Divider(height: 1, thickness: 1, color: color);
    return Column(
      children: <Widget>[
        Divider(height: 1, thickness: 2, color: color),
        const SizedBox(height: 3),
        Divider(height: 1, thickness: 1, color: color),
      ],
    );
  }
}
