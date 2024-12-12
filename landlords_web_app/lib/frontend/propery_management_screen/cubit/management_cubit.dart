// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:landlords_web_app/backend/landlords_repository/landlord.dart';
// import 'package:landlords_web_app/backend/landlords_repository/landlords_repository.dart';

// part 'management_state.dart';

// class ManagementCubit extends Cubit<ManagementState> {
//   final LandlordsRepository _landlordsRepository;
//   ManagementCubit(this._landlordsRepository) : super(const ManagementState());

//   Future<void> fetchLandlords() async {
//     emit(state.copyWith(status: LandlordsStatus.loading));
//     try {
//       List<Landlord> landlords = await _landlordsRepository.fetchLandlords();
//       emit(state.copyWith(
//           status: LandlordsStatus.success, landlords: landlords));
//     } catch (e, stackTrace) {
//       // Log the error and stack trace for debugging purposes
//       print('Error fetching landlords: $e');
//       print('Stack trace: $stackTrace');
//       emit(state.copyWith(status: LandlordsStatus.error));
//     }
//   }
// }
