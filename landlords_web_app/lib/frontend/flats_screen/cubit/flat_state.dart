part of 'flat_cubit.dart';

enum FlatStatus {
  initial,
  loading,
  success,
  error,
}

class FlatState extends Equatable {
  final FlatStatus status;
  final List<Flat> flats;
  const FlatState({
    this.status = FlatStatus.initial,
    this.flats = const [],
  });
  @override
  List<Object> get props => [status, flats];
  FlatState copyWith({
    FlatStatus? status,
    List<Flat>? flats,
  }) {
    return FlatState(
      status: status ?? this.status,
      flats: flats ?? this.flats,
    );
  }
}
