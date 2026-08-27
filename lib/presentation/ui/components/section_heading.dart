import 'package:flutter/material.dart';

import 'editorial_rule.dart';

class SectionHeading extends StatelessWidget {
  final String kicker;
  final String title;

  const SectionHeading({
    super.key,
    required this.kicker,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const EditorialRule(double: true),
        const SizedBox(height: 14),
        Text(kicker.toUpperCase(), style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 5),
        Text(title, style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 14),
        const EditorialRule(),
      ],
    );
  }
}
