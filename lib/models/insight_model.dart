import 'package:intl/intl.dart';

class Insight {
  int? today;
  int? yesterday;
  int? dayChange;
  double? dayPercent;
  int? thisWeek;
  int? lastWeek;
  int? weekChange;
  double? weekPercent;
  int? thisMonth;
  int? lastMonth;
  int? monthChange;
  int? allProperties;
  int? soldProperties;
  double? monthPercent;
  List<ViewData>? viewsByDay;
  List<ViewData>? viewsByWeek;
  List<ViewData>? viewsByMonth;

  Insight(
      {this.today,
      this.yesterday,
      this.dayChange,
      this.dayPercent,
      this.thisWeek,
      this.lastWeek,
      this.weekChange,
      this.weekPercent,
      this.thisMonth,
      this.lastMonth,
      this.monthChange,
      this.monthPercent,
      this.viewsByDay,
      this.viewsByWeek,
      this.viewsByMonth});

  Insight.fromJson(json) {
    today = json['today'];
    yesterday = json['yesterday'];
    dayChange = json['day_change'];
    dayPercent = json['day_percent'].toDouble();

    thisWeek = json['this_week'];
    lastWeek = json['last_week'];
    weekChange = json['week_change'];
    weekPercent = json['week_percent'].toDouble();

    allProperties = json['allProperties'] != null ? int.parse(json['allProperties'].toString()) : 0;
    soldProperties = json['soldProperties'] != null ? int.parse(json['soldProperties'].toString()) : 0;
    thisMonth = json['this_month'] != null ? int.parse(json['this_month'].toString()) : 0;
    lastMonth = json['last_month'] != null ? int.parse(json['last_month'].toString()) : 0;
    monthChange = json['month_change'];
    monthPercent = json['month_percent'].toDouble();

    if (json['views_by_day'] != null) {
      viewsByDay = <ViewData>[];
      json['views_by_day'].forEach((v) {
        viewsByDay!.add(ViewData.fromJson(v));
      });
      viewsByDay = viewsByDay?.reversed.toList();
      // var v = <ViewData>[];
      // for (var x in List.generate(30, (i) => i)) {
      //   dynamic dayExist = null;
      //   for(var y in viewsByDay!) {
      //     dayExist = y.createdAt == x.toString();
      //     if(dayExist) break;
      //   }
      //   if(dayExist) {
      //     v.add(viewsByDay[]);
      //   }
      // }
      //
      // dnd(viewsByDay);
    }
    if (json['views_by_week'] != null) {
      viewsByWeek = <ViewData>[];
      json['views_by_week'].forEach((v) {
        viewsByWeek!.add(ViewData.fromJson(v));
      });
    }
    if (json['views_by_month'] != null) {
      viewsByMonth = <ViewData>[];
      json['views_by_month'].forEach((v) {
        viewsByMonth!.add(ViewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['today'] = today;
    data['yesterday'] = yesterday;
    data['day_change'] = dayChange;
    data['day_percent'] = dayPercent;
    data['this_week'] = thisWeek;
    data['last_week'] = lastWeek;
    data['week_change'] = weekChange;
    data['week_percent'] = weekPercent;
    data['this_month'] = thisMonth;
    data['last_month'] = lastMonth;
    data['month_change'] = monthChange;
    data['month_percent'] = monthPercent;
    if (viewsByDay != null) {
      data['views_by_day'] = viewsByDay!.map((v) => v.toJson()).toList();
    }
    if (viewsByWeek != null) {
      data['views_by_week'] = viewsByWeek!.map((v) => v.toJson()).toList();
    }
    if (viewsByMonth != null) {
      data['views_by_month'] = viewsByMonth!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewData {
  String createdAt = '';
  num views = 0;
  int? createdYearMonth;
  int? createdDay;

  ViewData({this.createdAt = '', this.views = 0, this.createdYearMonth, this.createdDay});

  ViewData.fromJson(json) {
    try {
      createdAt = DateFormat('d').format(DateTime.parse(json['created_at'])).toString();
      views = json['views'] != null ? int.parse(json['views'].toString()) : 0;
    } catch (e) {
      createdAt = '';
      views = 0;
    }
    createdYearMonth = json['created_year_month'] != null ? int.parse(json['created_year_month'].toString()) : 0;
    createdDay = json['created_day'] != null ? int.parse(json['created_day'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['views'] = views;
    data['created_year_month'] = createdYearMonth;
    data['created_day'] = createdDay;
    return data;
  }
}
