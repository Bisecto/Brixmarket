class Insight {
  Insight({
    this.message,
    this.status,
    this.data,
  });

  final String? message;
  final bool? status;
  final Data? data;

  Insight copyWith({
    String? message,
    bool? status,
    Data? data,
  }) =>
      Insight(
        message: message ?? this.message,
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory Insight.fromJson(Map<String, dynamic> json) => Insight(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.totalProperties,
    this.totalViews,
    this.totalImpressions,
    this.viewsByDay4Month,
    this.savesByDay4Month,
    this.popularProperties,
  });

  final int? totalProperties;
  final int? totalViews;
  final int? totalImpressions;
  final List<SByDay4Month>? viewsByDay4Month;
  final List<SByDay4Month>? savesByDay4Month;
  final List<dynamic>? popularProperties;

  Data copyWith({
    int? totalProperties,
    int? totalViews,
    int? totalImpressions,
    List<SByDay4Month>? viewsByDay4Month,
    List<SByDay4Month>? savesByDay4Month,
    List<dynamic>? popularProperties,
  }) =>
      Data(
        totalProperties: totalProperties ?? this.totalProperties,
        totalViews: totalViews ?? this.totalViews,
        totalImpressions: totalImpressions ?? this.totalImpressions,
        viewsByDay4Month: viewsByDay4Month ?? this.viewsByDay4Month,
        savesByDay4Month: savesByDay4Month ?? this.savesByDay4Month,
        popularProperties: popularProperties ?? this.popularProperties,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalProperties: json["totalProperties"],
        totalViews: json["totalViews"],
        totalImpressions: json["totalImpressions"],
        viewsByDay4Month: json["viewsByDay4Month"] == null
            ? []
            : List<SByDay4Month>.from(
                json["viewsByDay4Month"]!.map((x) => SByDay4Month.fromJson(x))),
        savesByDay4Month: json["savesByDay4Month"] == null
            ? []
            : List<SByDay4Month>.from(
                json["savesByDay4Month"]!.map((x) => SByDay4Month.fromJson(x))),
        popularProperties: json["popularProperties"] == null
            ? []
            : List<dynamic>.from(json["popularProperties"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "totalProperties": totalProperties,
        "totalViews": totalViews,
        "totalImpressions": totalImpressions,
        "viewsByDay4Month": viewsByDay4Month == null
            ? []
            : List<dynamic>.from(viewsByDay4Month!.map((x) => x.toJson())),
        "savesByDay4Month": savesByDay4Month == null
            ? []
            : List<dynamic>.from(savesByDay4Month!.map((x) => x.toJson())),
        "popularProperties": popularProperties == null
            ? []
            : List<dynamic>.from(popularProperties!.map((x) => x)),
      };
}

class SByDay4Month {
  SByDay4Month({
    this.counts,
    this.day,
  });

  final int? counts;
  final int? day;

  SByDay4Month copyWith({
    int? counts,
    int? day,
  }) =>
      SByDay4Month(
        counts: counts ?? this.counts,
        day: day ?? this.day,
      );

  factory SByDay4Month.fromJson(Map<String, dynamic> json) => SByDay4Month(
        counts: json["counts"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "counts": counts,
        "day": day,
      };
}
