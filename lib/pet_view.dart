import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';
import 'package:pet_store/pet_page.dart';

class PetView extends StatelessWidget {
  final Pet pet;

  const PetView({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PetPage(pet: pet),
        ),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withOpacity(0.05),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                pet.photoUrls.firstOrNull ?? '',
                errorBuilder: (context, _, __) => const Icon(
                  size: 48,
                  Icons.pets,
                ),
              ),
            ),
            Text(
              pet.name ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
