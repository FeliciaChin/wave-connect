import 'package:new_pro/blocs/advertisement/advertisement_bloc.dart';

import '../../Page/models/models.dart';

abstract class BaseadvertisementRepository {
  Stream<List<Advertisement>> getAllAdvertisement();
}
