import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../repository/firebase_repository.dart';

part 'save_details_state.dart';
part 'save_details_cubit.freezed.dart';

class SaveDetailsCubit extends Cubit<SaveDetailsState> {
  SaveDetailsCubit({required FirebaseRepository firebaseRepository})
      : _firebaseRepository = firebaseRepository,
        super(const SaveDetailsState.initial());

  late final FirebaseRepository _firebaseRepository;

  Future saveCurrentDetails(
    String userName,
    String password,
    String polynomial,
    String derivative,
  ) async {
    emit(const SaveDetailsState.loading());
    try {
      final data = {
        "userName": userName,
        "password": password,
        "polynomial": polynomial,
        "derivative": derivative,
      };
      await _firebaseRepository.saveDetailsToFirestore(data);
      emit(SaveDetailsState.loaded(derivative: derivative));
    } catch (e) {
      SaveDetailsState.error(message: e.toString());
    }
  }
}
