// ignore_for_file: must_be_immutable

part of 'ride_bloc.dart';

enum ReservedModal { startModal, unlockingModal, ringModal }

abstract class RideState extends Equatable {
  RideHistoryModel? rideDetail;
  bool isLoading;
  ErrorState? error;

  RideState({
    this.rideDetail,
    this.isLoading = false,
    this.error,
  });

  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  });
}

class RideInitial extends RideState {
  RideInitial({
    super.rideDetail,
    super.isLoading,
    super.error,
  });

  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideInitial(
      rideDetail: rideDetail ?? this.rideDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RideFirst extends RideState {
  RideFirst({
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideFirst(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RideReserving extends RideState {
  final Scooter selectedScooter;
  RideReserving({
    required this.selectedScooter,
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [selectedScooter, rideDetail, isLoading, error];

  @override
  RideState copyWith({
    Scooter? selectedScooter,
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideReserving(
      selectedScooter: selectedScooter ?? this.selectedScooter,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RideReserved extends RideState {
  ReservedModal? modal;

  RideReserved({
    this.modal,
    super.rideDetail,
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    ReservedModal? modal,
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideReserved(
      modal: modal,
      rideDetail: rideDetail ?? this.rideDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// class RingModalRideReserved extends RideReserved {}

// class UnlockingModalRideReserved extends RideReserved {}

// class StartModalRideReserved extends RideReserved {}

class RideInProgress extends RideState {
  RideInProgress({
    super.rideDetail,
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideInProgress(
      rideDetail: rideDetail ?? this.rideDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RidePaused extends RideState {
  RidePaused({
    super.rideDetail,
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RidePaused(
      rideDetail: rideDetail ?? this.rideDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class RideFinished extends RideState {
  RideFinished({
    super.rideDetail,
    super.isLoading,
    super.error,
  });
  @override
  List<Object?> get props => [rideDetail, isLoading, error];

  @override
  RideState copyWith({
    RideHistoryModel? rideDetail,
    bool? isLoading,
    ErrorState? error,
  }) {
    return RideFinished(
      rideDetail: rideDetail ?? this.rideDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
