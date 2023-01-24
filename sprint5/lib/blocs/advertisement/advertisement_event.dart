part of 'advertisement_bloc.dart';

abstract class advertisementEvent extends Equatable {
  const advertisementEvent();

  @override
  List<Object> get props => [];
}

class LoadAdvertisement extends advertisementEvent {}

class UpdateAdvertisement extends advertisementEvent {
  final List<Advertisement> advertisement;

  UpdateAdvertisement(this.advertisement);

  @override
  List<Object> get props => [advertisement];
}
