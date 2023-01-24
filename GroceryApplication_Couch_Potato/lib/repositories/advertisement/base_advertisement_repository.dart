import 'package:Couch_Potato/blocs/advertisement/advertisement_bloc.dart';

import '../../Page/models/models.dart';

abstract class BaseadvertisementRepository {
  Stream<List<Advertisement>> getAllAdvertisement();
}
