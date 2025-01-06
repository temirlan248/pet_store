import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart';

class PetsCubit extends Cubit<List<Pet>> {
  final PetApi _petApi;

  PetsCubit(
    this._petApi,
  ) : super([]) {
    getPets();
  }

  Future<void> getPets() async {
    final pets = await _petApi.findPetsByStatus(
      status: BuiltList.from(
        [
          PetStatusEnum.available.name,
        ],
      ),
    );
    emit(pets.data?.asList() ?? []);
  }
}
