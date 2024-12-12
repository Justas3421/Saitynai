part of 'buildings_cubit.dart';

enum BuildingStatus {
  initial,
  loading,
  success,
  error,
}

class BuildingState extends Equatable {
  final BuildingStatus status;
  final List<Building> buildings;
  const BuildingState({
    this.status = BuildingStatus.initial,
    this.buildings = const [],
  });
  @override
  List<Object> get props => [status, buildings];
  BuildingState copyWith({
    BuildingStatus? status,
    List<Building>? buildings,
  }) {
    return BuildingState(
      status: status ?? this.status,
      buildings: buildings ?? this.buildings,
    );
  }
}
