import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart';
import 'package:pet_store/bloc_observer.dart';
import 'package:pet_store/pet_cubit.dart';
import 'package:pet_store/pets_cubit.dart';
import 'package:pet_store/pets_page.dart';

void main() {
  Bloc.observer = const PetObserver();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Openapi(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PetsCubit(
              context.read<Openapi>().getPetApi(),
            ),
          ),
          BlocProvider(
            create: (context) => PetCubit(
              context.read<Openapi>().getPetApi(),
            ),
          ),
        ],
        child: const MaterialApp(
          home: PetsPage(),
        ),
      ),
    );
  }
}
