class Location {
  String? timeZone;
  Location({
    this.timeZone,
  });
  
  factory Location.fromJson(dynamic json) {
    if (json == null) {
      return Location();
    }

    return Location(
      timeZone: json['timezone'],
    );
  }
}
