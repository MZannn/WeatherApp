class LocationModel {
  String? id;
  String? propinsi;
  String? kota;
  String? kecamatan;
  String? lat;
  String? lon;

  LocationModel({
    this.id,
    this.propinsi,
    this.kota,
    this.kecamatan,
    this.lat,
    this.lon,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"],
        propinsi: json["propinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propinsi": propinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "lat": lat,
        "lon": lon,
      };
}
