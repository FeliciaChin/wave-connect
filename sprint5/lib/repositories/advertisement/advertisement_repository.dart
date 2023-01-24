import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Page/models/advertisement.dart';
import '/repositories/advertisement/base_advertisement_repository.dart';

class AdvertisementRepository extends BaseadvertisementRepository {
  final FirebaseFirestore _firebaseFirestore;

  AdvertisementRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Advertisement>> getAllAdvertisement() {
    return _firebaseFirestore
        .collection('advertisement')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Advertisement.fromSnapshot(doc)).toList();
    });
  }
}
