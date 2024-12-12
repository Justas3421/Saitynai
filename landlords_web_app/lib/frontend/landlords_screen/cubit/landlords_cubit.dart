import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
import 'package:landlords_web_app/backend/landlords_repository/landlords_repository.dart';

part 'landlords_state.dart';

class LandlordsCubit extends Cubit<LandlordsState> {
  final LandlordsRepository _landlordsRepository;
  LandlordsCubit(this._landlordsRepository) : super(const LandlordsState());

  Future<void> fetchLandlords() async {
    emit(state.copyWith(status: LandlordsStatus.loading));
    try {
      List<Landlord> landlords = await _landlordsRepository.fetchLandlords();
      emit(state.copyWith(
          status: LandlordsStatus.success, landlords: landlords));
    } catch (e, stackTrace) {
      // Log the error and stack trace for debugging purposes
      debugPrint('Error fetching landlords: $e');
      debugPrint('Stack trace: $stackTrace');
      emit(state.copyWith(status: LandlordsStatus.error));
    }
  }
}
