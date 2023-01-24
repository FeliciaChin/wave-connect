part of 'advertisement_bloc.dart';

abstract class advertisementState extends Equatable {
  const advertisementState();

  @override
  List<Object> get props => [];
}

class advertisementLoading extends advertisementState {}

class advertisementLoaded extends advertisementState {
  final List<Advertisement> advertisement;

  advertisementLoaded({this.advertisement = const <Advertisement>[]});

  @override
  List<Object> get props => [advertisement];
}
