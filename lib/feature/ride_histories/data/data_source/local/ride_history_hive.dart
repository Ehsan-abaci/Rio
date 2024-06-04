import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/ride_histories/domain/entities/ride_detail_entity.dart';

abstract class RideHistoryHive {
  Future<void> saveRide(RideDetailEntity data);
  List<RideDetailEntity> fetchRideHistories();
}

class RideHistoryHiveImpl extends RideHistoryHive {
  static Box<RideDetailEntity> rideHistoryBox =
      Hive.box(Constant.rideHistoryBox);

  @override
  List<RideDetailEntity> fetchRideHistories() {
    return rideHistoryBox.values.toList();
  }

  @override
  Future<void> saveRide(RideDetailEntity data) async {
    await rideHistoryBox.add(data);
  }
}
