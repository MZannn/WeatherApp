class WeatherModel {
  String? jamCuaca;
  String? kodeCuaca;
  String? cuaca;
  String? humidity;
  String? tempC;
  String? tempF;

  WeatherModel({
    this.jamCuaca,
    this.kodeCuaca,
    this.cuaca,
    this.humidity,
    this.tempC,
    this.tempF,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        jamCuaca: json["jamCuaca"],
        kodeCuaca: json["kodeCuaca"],
        cuaca: json["cuaca"]!,
        humidity: json["humidity"],
        tempC: json["tempC"],
        tempF: json["tempF"],
      );
}
