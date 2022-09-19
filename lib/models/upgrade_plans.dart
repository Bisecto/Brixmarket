import 'package:brixmarket/controllers/instance.dart';

class UpgradePlan {
  String? title;
  String? id;
  int? userPrice;
  int? amount;
  int? level;
  int? agentPrice;
  int? agencyPrice;
  int? userLevel;
  int? agentLevel;
  int? agencyLevel;
  String? description;
  List<String>? features;

  UpgradePlan(this.title, this.id, this.userPrice, this.agentPrice, this.agencyPrice, this.userLevel, this.agentLevel, this.agencyLevel, this.description, this.features);

  UpgradePlan.fromJson(json) {
    id = json['id'];
    title = json['title'];
    userPrice = int.parse(json['user_price'].toString());
    agentPrice = int.parse(json['agent_price'].toString());
    agencyPrice = int.parse(json['agency_price'].toString());
    userLevel = int.parse(json['user_level'].toString());
    agentLevel = int.parse(json['agent_level'].toString());
    agencyLevel = int.parse(json['agency_level'].toString());
    description = json['description'];
    amount = user.isUser == true
        ? userPrice
        : user.isAgent == true
            ? agentPrice
            : agencyPrice;
    level = user.isUser == true
        ? userLevel
        : user.isAgent == true
            ? agentLevel
            : agencyLevel;
    features = json['features'].toString().split('~');
  }
}
