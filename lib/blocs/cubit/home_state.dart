part of 'home_cubit.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final Position? position;
  final LocationModel locationModel;
  final List<String> listLocation;
  final List<WeatherModel> listWeatherModel;
  const HomeLoaded(
      {this.position,
      required this.locationModel,
      required this.listLocation,
      required this.listWeatherModel});
  @override
  List<Object> get props => [position!, locationModel];
}
