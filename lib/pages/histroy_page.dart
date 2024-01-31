import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/pet.dart';
import '../BloC/pet_bloc.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption History"),
      ),
      body: BlocBuilder<PetBloc, List<Pet>>(
        builder: (context, pets) {
          // Filter out the adopted pets
          List<Pet> adoptedPets = pets.where((pet) => pet.isAdopted).toList();

          // Sort adopted pets by adopted date, handling null values
          adoptedPets.sort((a, b) {
            if (a.adoptedDate != null && b.adoptedDate != null) {
              return b.adoptedDate!.compareTo(a.adoptedDate!);
            }
            if (a.adoptedDate == null) return 1;
            if (b.adoptedDate == null) return -1;
            return 0;
          });

          return adoptedPets.isEmpty
              ? const Center(child: Text("No history of adoptions"))
              : ListView.builder(
                  itemCount: adoptedPets.length,
                  itemBuilder: (context, index) {
                    final pet = adoptedPets[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pet.imageUrl),
                      ),
                      title: Text(pet.name),
                      subtitle: Text(
                          "${pet.breed}, Adopted on ${pet.adoptedDate?.toLocal() ?? 'Date unknown'}"),
                    );
                  },
                );
        },
      ),
    );
  }
}
