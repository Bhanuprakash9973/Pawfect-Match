import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawfect_match/data/sample_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/pet.dart';
import 'pet_event.dart';

class PetBloc extends Bloc<PetEvent, List<Pet>> {
  PetBloc() : super([]) {
    on<UpdatePet>((event, emit) async {
      List<Pet> updatedPets = List.from(state);
      int index =
          updatedPets.indexWhere((pet) => pet.id == event.updatedPet.id);
      if (index != -1) {
        updatedPets[index] = event.updatedPet;
        await _savePetsToPrefs(updatedPets);
        emit(updatedPets);
      }
    });

    _loadPetsFromPrefs().then((loadedPets) {
      // ignore: invalid_use_of_visible_for_testing_member
      emit(loadedPets);
    });
  }

  Future<void> _savePetsToPrefs(List<Pet> pets) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> petJson = pets.map((pet) => json.encode(pet.toMap())).toList();
    await prefs.setStringList('pets', petJson);
  }

  Future<List<Pet>> _loadPetsFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? petJson = prefs.getStringList('pets');
    if (petJson != null) {
      return petJson.map((string) => Pet.fromMap(json.decode(string))).toList();
    }
    return samplePets; // Use your initial sample data if no data in prefs
  }
}
