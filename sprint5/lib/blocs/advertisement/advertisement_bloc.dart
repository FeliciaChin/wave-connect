import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Page/models/models.dart';
import '/repositories/advertisement/advertisement_repository.dart';

part 'advertisement_event.dart';
part 'advertisement_state.dart';

class AdvertisementBloc extends Bloc<advertisementEvent, advertisementState> {
  final AdvertisementRepository _advertisementRepository;
  StreamSubscription? _advertisementSubscription;

  AdvertisementBloc({required AdvertisementRepository AdvertisementRepository})
      : _advertisementRepository = AdvertisementRepository,
        super(advertisementLoading()) {
    on<LoadAdvertisement>(_onLoadAdvertisement);
    on<UpdateAdvertisement>(_onUpdateAdvertisement);
  }

  void _onLoadAdvertisement(
    LoadAdvertisement event,
    Emitter<advertisementState> emit,
  ) {
    _advertisementSubscription?.cancel();
    _advertisementSubscription = _advertisementRepository.getAllAdvertisement().listen(
          (advertisement) => add(
            UpdateAdvertisement(advertisement),
          ),
        );
  }

  void _onUpdateAdvertisement(
    UpdateAdvertisement event,
    Emitter<advertisementState> emit,
  ) {
    emit(
      advertisementLoaded(advertisement: event.advertisement),
    );
  }
}
