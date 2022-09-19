import 'package:brixmarket/controllers/instance.dart';
import 'package:flutter/material.dart';

import '../../models/property_model.dart';
import '../../models/user_model.dart';
import '../../utils/utils.dart';

class SavePropertyIcon extends StatelessWidget {
  final Property property;
  final User user;
  final double? size;
  final Color? color;
  final List state;
  const SavePropertyIcon({Key? key, required this.property, required this.user, this.size, this.color, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => homeCtrl.saveProperty(property),
      child: Utils.savedPropertyIcon(property.id, size: size ?? 24, user: user, color: color, state: state),
    );
  }
}

class SavePropertyIconText extends StatelessWidget {
  final Property property;
  final User user;
  final List state;
  const SavePropertyIconText({Key? key, required this.property, required this.user, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => homeCtrl.saveProperty(property),
      child: Container(
        margin: const EdgeInsets.only(right: 25),
        child: Row(
          children: [
            Utils.savedPropertyIcon(property.id, size: 18, user: user, state: state),
            const SizedBox(width: 8),
            Utils.savedPropertyText(property.id, size: 16),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
