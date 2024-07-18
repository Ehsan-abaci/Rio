import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_scooter/core/resources/network_info.dart';
import 'package:share_scooter/locator.dart';

part 'network_connection_state.dart';

class NetworkConnectionCubit extends Cubit<NetworkConnectionState> {
  NetworkConnectionCubit() : super(NetworkConnectionInitial());

  Future<void> checkNetworkConnection() async {
    emit(NetworkConnectionLoading());
    final connection = await di<NetworkInfo>().isConnected;
    if (connection) {
      emit(NetworkConnectionSuccess());
    } else {
      emit(NetworkConnectionError());
    }
  }
}
