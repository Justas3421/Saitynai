part of 'landlords_cubit.dart';

enum LandlordsStatus {
  initial,
  loading,
  success,
  error,
}

class LandlordsState extends Equatable {
  final LandlordsStatus status;
  final List<Landlord> landlords;

  const LandlordsState({
    this.status = LandlordsStatus.initial,
    this.landlords = const [],
  });

  LandlordsState copyWith({
    LandlordsStatus? status,
    List<Landlord>? landlords,
  }) {
    return LandlordsState(
      status: status ?? this.status,
      landlords: landlords ?? this.landlords,
    );
  }

  @override
  List<Object?> get props => [status, landlords];
}
