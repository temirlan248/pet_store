import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openapi/openapi.dart';
import 'package:pet_store/pet_view.dart';
import 'package:pet_store/pets_cubit.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PetsCubit, List<Pet>>(
      builder: (context, pets) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: IconButton(
          onPressed: context.read<PetsCubit>().getPets,
          icon: const Icon(
            Icons.refresh,
            color: Colors.green,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverList.separated(
                itemBuilder: (context, index) => PetView(
                  pet: pets[index],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: pets.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
