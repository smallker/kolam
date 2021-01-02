// To parse this JSON data, do
//
//     final kolamModel = kolamModelFromMap(jsonString);

import 'dart:convert';

class KolamModel {
  KolamModel({
    this.id,
    this.timestamp,
    this.temperature,
    this.flow,
    this.ph,
  });

  String id;
  int timestamp;
  String temperature;
  String flow;
  String ph;

  factory KolamModel.fromJson(String str) =>
      KolamModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KolamModel.fromMap(Map<dynamic, dynamic> json) => KolamModel(
        id: json["id"] == null ? 'N/A' : json["id"],
        timestamp: json["timestamp"] == null
            ? '0'
            : int.parse(json["timestamp"]) * 1000,
        temperature: json["temperature"] == null ? 'N/A' : json["temperature"],
        flow: json["flow"] == null ? 'N/A' : json["flow"],
        ph: json["ph"] == null ? 'N/A' : json["ph"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "timestamp": timestamp,
        "temperature": temperature,
        "flow": flow,
        "ph": ph,
      };
}
