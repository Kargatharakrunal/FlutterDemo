import 'dart:convert';

class Details {
  String? name;
  Data? data;

  Details({
    this.name,
    this.data,
  });

  factory Details.fromJson(String str) => Details.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    name: json["name"],
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "data": data?.toMap(),
  };
}

class Data {
  int? year;
  double? price;
  String? cpuModel;
  String? hardDiskSize;

  Data({
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    year: json["year"],
    price: json["price"]?.toDouble(),
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
  );

  Map<String, dynamic> toMap() => {
    "year": year,
    "price": price,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
  };
}


class Welcomes {
  String? id;
  String? name;
  DateTime? createdAt;
  Data? data;

  Welcomes({
    this.id,
    this.name,
    this.createdAt,
    this.data,
  });

  factory Welcomes.fromJson(String str) => Welcomes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Welcomes.fromMap(Map<String, dynamic> json) => Welcomes(
    id: json["id"],
    name: json["name"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "createdAt": createdAt?.toIso8601String(),
    "data": data?.toMap(),
  };
}

class DataResponse {
  int? year;
  double? price;
  String? cpuModel;
  String? hardDiskSize;

  DataResponse({
    this.year,
    this.price,
    this.cpuModel,
    this.hardDiskSize,
  });

  factory DataResponse.fromJson(String str) => DataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataResponse.fromMap(Map<String, dynamic> json) => DataResponse(
    year: json["year"],
    price: json["price"]?.toDouble(),
    cpuModel: json["CPU model"],
    hardDiskSize: json["Hard disk size"],
  );

  Map<String, dynamic> toMap() => {
    "year": year,
    "price": price,
    "CPU model": cpuModel,
    "Hard disk size": hardDiskSize,
  };
}
