import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/location_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/base_api.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final API api = API();
  List<LocationModel> listLocationModel = [];
  late LocationModel locationModel;
  List<String> listId = [];
  List<String> listLocation = [];
  void getLocation() async {
    emit(HomeLoading());
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      var response = await api.dio.get('cuaca/wilayah.json');
      listLocationModel = List<LocationModel>.from(
        response.data.map(
          (e) => LocationModel.fromJson(e),
        ),
      );
      double minDistance = 10000;

      for (var i = 0; i < listLocationModel.length; i++) {
        final haversine = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          double.parse(listLocationModel[i].lat!),
          double.parse(listLocationModel[i].lon!),
        );
        listLocation.add(listLocationModel[i].kecamatan!);
        listId.add(listLocationModel[i].id!);
        if (haversine < minDistance) {
          locationModel = listLocationModel[i];
          try {
            var listWeather =
                await api.dio.get('cuaca/${locationModel.id}.json');
            List<WeatherModel> listWeatherModel = List<WeatherModel>.from(
              listWeather.data.map(
                (e) => WeatherModel.fromJson(e),
              ),
            );
            emit(
              HomeLoaded(
                position: position,
                locationModel: listLocationModel[i],
                listLocation: listLocation,
                listWeatherModel: listWeatherModel,
              ),
            );
          } catch (e) {
            e.toString();
          }
        }
      }
    } catch (e) {
      e.toString();
    }
  }

  void changeLocation(int id) async {
    emit(HomeLoading());
    try {
      var response = await api.dio.get('cuaca/${listId[id]}.json');
      List<WeatherModel> listWeatherModel = List<WeatherModel>.from(
        response.data.map(
          (e) => WeatherModel.fromJson(e),
        ),
      );
      emit(
        HomeLoaded(
          locationModel: listLocationModel[id],
          listLocation: listLocation,
          listWeatherModel: listWeatherModel,
        ),
      );
    } catch (e) {}
  }
}
