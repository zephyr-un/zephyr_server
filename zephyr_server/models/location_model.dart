// Location Model Class

class Location {

  Location(this.latitude, this.longitude, this.name);
  final double latitude;
  final double longitude;
  final String name;

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
      };

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      json['latitude'] as double,
      json['longitude'] as double,
      json['name'] as String,
    );
  }

  
}
