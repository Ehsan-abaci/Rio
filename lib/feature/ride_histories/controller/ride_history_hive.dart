import 'package:hive/hive.dart';
import 'package:share_scooter/core/utils/constants.dart';
import 'package:share_scooter/feature/ride_histories/model/ride_history_model.dart';

abstract class RideHistoryHive {
  Future<void> saveRide(RideHistoryModel data);
  List<RideHistoryModel> fetchRideHistories();
}

class RideHistoryHiveImpl extends RideHistoryHive {
  static Box<RideHistoryModel> rideHistoryBox =
      Hive.box(Constant.rideHistoryBox);

  @override
  List<RideHistoryModel> fetchRideHistories() {
    return rideHistoryBox.values.toList();
  }

  @override
  Future<void> saveRide(RideHistoryModel data) async {
    await rideHistoryBox.add(data);
  }
}
