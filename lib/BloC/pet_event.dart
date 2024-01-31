// pet_event.dart
import 'package:equatable/equatable.dart';
import '../models/pet.dart';

abstract class PetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePet extends PetEvent {
  final Pet updatedPet;

  UpdatePet(this.updatedPet);

  @override
  List<Object?> get props => [updatedPet];
}
