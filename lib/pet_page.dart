import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:openapi/openapi.dart';
import 'package:pet_store/pet_cubit.dart';
import 'package:pet_store/pet_state.dart';

class PetPage extends StatefulWidget {
  final Pet pet;

  const PetPage({
    super.key,
    required this.pet,
  });

  @override
  State<PetPage> createState() => _PetPageState();
}

class _PetPageState extends State<PetPage> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PetCubit, PetState>(
      listener: (context, state) {
        if (state case PetSuccess _) {
          Future.delayed(
            const Duration(seconds: 1),
            () {
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          );
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.pet.name ?? '',
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final file =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      setState(() {
                        this.file = File(file.path);
                      });
                    }
                  },
                  child: SizedBox.square(
                    dimension: 200,
                    child: _PetImage(
                      file: file,
                      image: widget.pet.photoUrls.firstOrNull,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: switch (state) {
                    PetInitial() => const SizedBox.shrink(),
                    PetLoading() => const CircularProgressIndicator(),
                    PetSuccess() => const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    PetFailure() => const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                  },
                ),
              ),
              SliverFillRemaining(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PetCubit>().save(
                            petId: widget.pet.id!,
                            file: file != null
                                ? MultipartFile.fromFileSync(file!.path)
                                : null,
                          );
                    },
                    child: const Text('Save'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PetImage extends StatelessWidget {
  final File? file;
  final String? image;

  const _PetImage({
    super.key,
    this.file,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return Image.file(
        file ??
            (throw StateError('File checked for null, but still null given')),
      );
    }
    if (image != null) {
      return Image.network(
        image ??
            (throw StateError('File checked for null, but still null given')),
      );
    }
    return const Icon(Icons.pets);
  }
}
