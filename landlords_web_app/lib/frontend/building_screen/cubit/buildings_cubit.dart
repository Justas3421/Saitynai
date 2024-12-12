import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/buildings_repository/building.dart';
import 'package:landlords_web_app/backend/buildings_repository/building_repository.dart';

part 'buildings_state.dart';

class BuildingCubit extends Cubit<BuildingState> {
  final BuildingRepository _buildingRepository;
  BuildingCubit(this._buildingRepository) : super(const BuildingState());

  Future<void> fetchBuildings(int landlordId) async {
    emit(state.copyWith(status: BuildingStatus.loading));
    try {
      List<Building> buildings =
          await _buildingRepository.fetchBuildings(landlordId);
      emit(
          state.copyWith(status: BuildingStatus.success, buildings: buildings));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching buildings: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: BuildingStatus.error));
    }
  }
}
