import 'package:brixmarket/controllers/instance.dart';
import 'package:flutter/material.dart';
import 'package:brixmarket/models/filter_property_model.dart'as filter;
import 'package:brixmarket/models/home_property_model.dart'as home;
import '../../models/property_model.dart';
import '../../models/user_model.dart';
import '../../utils/utils.dart';
import '../../../models/singleProperty_model.dart'as single;
import 'package:brixmarket/models/single_property_model.dart'as singleProperty;
class SaveProperty extends StatelessWidget {
  final singleProperty.Property property;
  final User user;
  final double? size;
  final Color? color;
  final List state;
  const SaveProperty({Key? key,required this.property, required this.user, this.size, this.color, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => homeCtrl.saveProperty1(property),
      child: Utils.savedPropertyIcon(property.id, size: size ?? 24, user: user, color: color, state: state),
    );  }
}

class SavehomeProperty extends StatelessWidget {
  final home.Latest property;
  final User user;
  final double? size;
  final Color? color;
  final List state;
  const SavehomeProperty({Key? key,required this.property, required this.user, this.size, this.color, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => homeCtrl.saveHomeProperty(property),
      child: Utils.savedPropertyIcon(property.id, size: size ?? 24, user: user, color: color, state: state),
    );  }
}

class SaveFilterPropertyIcon extends StatelessWidget {
  final filter.Property property;
  final User user;
  final double? size;
  final Color? color;
  final List state;
  const SaveFilterPropertyIcon({Key? key,required this.property, required this.user, this.size, this.color, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => homeCtrl.saveFilterProperty(property),
      child: Utils.savedPropertyIcon(property.id, size: size ?? 24, user: user, color: color, state: state),
    );
  }
}

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
