import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/flats_repository/flat.dart';
import 'package:landlords_web_app/backend/flats_repository/flat_repository.dart';

part 'flat_state.dart';

class FlatCubit extends Cubit<FlatState> {
  final FlatRepository _buildingRepository;
  FlatCubit(this._buildingRepository) : super(const FlatState());

  Future<void> fetchFlats(int landlordId, int buildingId) async {
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

  Future<void> addFlat(int landlordId, int buildingId, Flat flat) async {
    emit(state.copyWith(status: FlatStatus.loading));
    try {
      List<Flat> flats = List.from(state.flats);
      flats.add(flat);
      unawaited(_buildingRepository.createFlat(
          landlordId: landlordId, buildingId: buildingId, flat));
      emit(state.copyWith(status: FlatStatus.success, flats: flats));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching buildings: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: FlatStatus.error));
    }
  }

  Future<void> updateFlat(int landlordId, int buildingId, Flat flat) async {
    emit(state.copyWith(status: FlatStatus.loading));
    try {
      List<Flat> flats = List.from(state.flats);
      flats[flats.indexWhere((element) => element.buildingId == buildingId)] =
          flat;
      unawaited(_buildingRepository.updateFlat(
          landlordId: landlordId,
          buildingId: buildingId,
          flatId: flat.flatId,
          flat));
      emit(state.copyWith(status: FlatStatus.success, flats: flats));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching buildings: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: FlatStatus.error));
    }
  }

  Future<void> deleteFlat(int landlordId, int buildingId, Flat flat) async {
    emit(state.copyWith(status: FlatStatus.loading));
    try {
      List<Flat> buildings = List.from(state.flats);
      buildings.remove(flat);
      unawaited(_buildingRepository.deleteFlat(
          landlordId: landlordId, buildingId: buildingId, flatId: flat.flatId));
      emit(state.copyWith(status: FlatStatus.success, flats: buildings));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching buildings: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: FlatStatus.error));
    }
  }
}
