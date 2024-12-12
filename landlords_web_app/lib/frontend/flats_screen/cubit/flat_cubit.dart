import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/flats_repository/flat.dart';
import 'package:landlords_web_app/backend/flats_repository/flat_repository.dart';

part 'flat_state.dart';

class FlatCubit extends Cubit<FlatState> {
  final FlatRepository _buildingRepository;
  FlatCubit(this._buildingRepository) : super(const FlatState());

  Future<void> fetchBuildings(int landlordId, int buildingId) async {
    emit(state.copyWith(status: FlatStatus.loading));
    try {
      List<Flat> buildings = await _buildingRepository.fetchFlats(
          landlordId: landlordId, buildingId: buildingId);
      emit(state.copyWith(status: FlatStatus.success, flats: buildings));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching buildings: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: FlatStatus.error));
    }
  }
}
