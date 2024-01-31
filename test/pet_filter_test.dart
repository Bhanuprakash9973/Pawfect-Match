import 'package:flutter_test/flutter_test.dart';
import 'package:pawfect_match/models/pet.dart'; // Import your Pet class
import 'package:pawfect_match/pages/home_page.dart'; // Or wherever you put PetFilter

void main() {
  group('PetFilter Tests', () {
    test('filters pets by breed', () {
      var pets = [
        Pet(
          id: '1',
          name: 'Charlie',
          age: 2,
          price: 4000.0,
          breed: 'labrador retriever',
          gender: 'male',
          isAdopted: false,
          imageUrl:
              'https://th.bing.com/th/id/OIP.aqF33gxnIodSAMxUhOeGOQHaE8?w=263&h=180&c=7&r=0&o=5&pid=1.7',
        ),
        Pet(
          id: '2',
          name: 'Max',
          age: 3,
          price: 7500.0,
          breed: 'Golden retriever',
          gender: 'female',
          isAdopted: false,
          imageUrl:
              'https://petdogowner.com/wp-content/uploads/2021/04/AdobeStock_133322407-scaled.jpeg',
        ),
        Pet(
            id: '3',
            name: 'Bella',
            age: 1,
            price: 5000.0,
            breed: 'German Shepherd',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.NRsZMDAGZ95bgweplhS8swHaEo?w=233&h=180&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '4',
            name: 'Lucy',
            age: 4,
            price: 6000.0,
            breed: 'Beagle',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.taiby-6L8JG2Rpl8jXxDeAHaE0?w=257&h=180&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '5',
            name: 'Daisy',
            age: 3,
            price: 4500.0,
            breed: 'Dachshund',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.YNFafsllNL1JUaq7MTSFIwHaFA?w=315&h=180&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '6',
            name: 'Buddy',
            age: 2,
            price: 5500.0,
            breed: 'Boxer',
            gender: 'male',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.05CcW61GGdklMLzY7ZfbgwHaIa?w=153&h=180&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '7',
            name: 'Molly',
            age: 5,
            price: 7000.0,
            breed: 'Poodle',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.xXiK1bvxuxlwBp8oJpEwNwHaE8?w=274&h=183&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '8',
            name: 'Bailey',
            age: 4,
            price: 8000.0,
            breed: 'Bulldog',
            gender: 'male',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.I3zbW6yrvcyJqo51FiLNjQHaHG?w=198&h=189&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '9',
            name: 'Maggie',
            age: 2,
            price: 3500.0,
            breed: 'Shih Tzu',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.oemvLEk0emWuKdMfy0kptQHaE7?w=248&h=180&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '10',
            name: 'Oscar',
            age: 1,
            price: 5000.0,
            breed: 'Cocker Spaniel',
            gender: 'male',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.quXzSnNls5mCqqsqcz3S2AHaJ4?w=154&h=205&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '11',
            name: 'Lola',
            age: 3,
            price: 4500.0,
            breed: 'French Bulldog',
            gender: 'female',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.L_Dc8wG5jSl5g85Odkk8xQHaFn?w=321&h=194&c=7&r=0&o=5&pid=1.7'),
        Pet(
            id: '12',
            name: 'Jake',
            age: 4,
            price: 6500.0,
            breed: 'Rottweiler',
            gender: 'male',
            isAdopted: false,
            imageUrl:
                'https://th.bing.com/th/id/OIP.Notw-H9k2i8G3AQUnNjb_AHaE8?w=301&h=201&c=7&r=0&o=5&pid=1.7'),
      ];
      var filtered = PetFilter.filterPets(
        pets: pets,
        searchText: '',
        maxAge: 20,
        minPrice: 0,
        maxPrice: 20000,
        gender: 'All',
        breed: 'Labrador Retriever',
      );

      // Check if the filtered list contains only pets of the specified breed
      expect(
          filtered
              .every((pet) => pet.breed.toLowerCase() == 'labrador retriever'),
          isTrue);
    });
  });
}
