class Insight {
  String? message;
  bool? status;
  Datum? data;

  Insight({this.message, this.status, this.data});

  Insight.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Datum.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Datum {
  int? totalProperties;
  int? totalViews;
  int? totalImpressions;
  List<ViewsByDay4Month>? viewsByDay4Month;
  List<ViewsByDay4Month>? savesByDay4Month;
  List<dynamic>? popularProperties;

  Datum(
      {this.totalProperties,
      this.totalViews,
      this.totalImpressions,
      this.viewsByDay4Month,
      this.savesByDay4Month,
      this.popularProperties});

  Datum.fromJson(Map<String, dynamic> json) {
    totalProperties = json['totalProperties'];
    totalViews = json['totalViews'];
    totalImpressions = json['totalImpressions'];
    if (json['viewsByDay4Month'] != null) {
      viewsByDay4Month = <ViewsByDay4Month>[];
      json['viewsByDay4Month'].forEach((v) {
        viewsByDay4Month!.add(ViewsByDay4Month.fromJson(v));
      });
    }
    if (json['savesByDay4Month'] != null) {
      savesByDay4Month = <ViewsByDay4Month>[];
      json['savesByDay4Month'].forEach((v) {
        savesByDay4Month!.add(ViewsByDay4Month.fromJson(v));
      });
    }
    if (json['popularProperties'] != null) {
      popularProperties = json["popularProperties"] == null
          ? []
          : List<dynamic>.from(json["popularProperties"]!.map((x) => x));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalProperties'] = totalProperties;
    data['totalViews'] = totalViews;
    data['totalImpressions'] = totalImpressions;
    if (viewsByDay4Month != null) {
      data['viewsByDay4Month'] =
          viewsByDay4Month!.map((v) => v.toJson()).toList();
    }
    if (savesByDay4Month != null) {
      data['savesByDay4Month'] =
          savesByDay4Month!.map((v) => v.toJson()).toList();
    }
    if (popularProperties != null) {
      data['popularProperties'] =
          popularProperties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViewsByDay4Month {
  int? counts;
  int? day;

  ViewsByDay4Month({this.counts, this.day});

  ViewsByDay4Month.fromJson(Map<String, dynamic> json) {
    counts = json['counts'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['counts'] = counts;
    data['day'] = day;
    return data;
  }
}
