class UserLocation {
  String name, type;
  double distance;

  UserLocation({
    required this.name,
    required this.type,
    required this.distance,
  });

  factory UserLocation.fromJson(Map<String, dynamic> map) {
    return UserLocation(
        name: map['name'],
        type: map['type'].toString(),
        distance: map['distance'] / 1000);
  }
}

class MyLocation {
  String name, id;
  String? type, qtype;
  double lat, long;
  int? distance;

  MyLocation(
      {required this.name,
      required this.id,
      required this.lat,
      required this.long,
      this.distance,
      this.type,
      this.qtype});

  Map get toJson {
    final map = {
      "name": name,
      "id": id,
      "lat": lat,
      "long": long,
      "dist": distance,
      "type": type,
      "qtype": qtype
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }
}
