import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart';
import 'package:pet_store/pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final PetApi _petApi;

  PetCubit(
    this._petApi,
  ) : super(PetInitial());

  Future<void> save({
    required int petId,
    MultipartFile? file,
  }) async {
    emit(PetLoading());
    try {
      await _petApi.uploadFile(
        petId: petId,
        file: file,
      );
      emit(PetSuccess());
    } catch (e) {
      print(e);
      emit(PetFailure());
    }
  }
}
