import 'package:flutter/material.dart';
import 'package:pawfect_match/pages/histroy_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pawfect_match/pet_bloc.dart';
import '../models/pet.dart';
import '../data/sample_data.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGender = 'All';
  String _selectedBreed = 'All';
  double _selectedMaxAge = 20;
  double _selectedMinPrice = 0;
  double _selectedMaxPrice = 20000;
  List<String> breeds = [
    'All',
    'Labrador Retriever',
    'Golden Retriever',
    'German Shepherd',
    'Beagle',
    'Bulldog',
    'Poodle',
    'Shih Tzu',
    'Cocker Spaniel',
    'French Bulldog',
    'Rottweiler'
  ]; // Add all breeds you need
  List<String> genders = ['All', 'Male', 'Female'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() async {
    double tempMaxAge = _selectedMaxAge;
    double tempMinPrice = _selectedMinPrice;
    double tempMaxPrice = _selectedMaxPrice;
    String tempGender = _selectedGender;
    String tempBreed = _selectedBreed;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Pets'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Age filter
                Text('Max Age: ${tempMaxAge.toInt()} years'),
                Slider(
                  value: tempMaxAge,
                  min: 0,
                  max: 20,
                  divisions: 20,
                  label: tempMaxAge.toInt().toString(),
                  onChanged: (double value) {
                    setState(() {
                      tempMaxAge = value;
                    });
                  },
                ),
                // Price filter
                Text(
                    'Price Range: ₹${tempMinPrice.toInt()} - ₹${tempMaxPrice.toInt()}'),
                RangeSlider(
                  values: RangeValues(tempMinPrice, tempMaxPrice),
                  min: 0,
                  max: 20000,
                  divisions: 40,
                  labels: RangeLabels(
                    tempMinPrice.toInt().toString(),
                    tempMaxPrice.toInt().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      tempMinPrice = values.start;
                      tempMaxPrice = values.end;
                    });
                  },
                ),
                const Text('Gender'),
                // Gender filter
                DropdownButton<String>(
                  value: tempGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      tempGender = newValue!;
                    });
                  },
                  items: genders.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                // Breed filter
                const Text('Breed'),
                DropdownButton<String>(
                  value: tempBreed,
                  onChanged: (String? newValue) {
                    setState(() {
                      tempBreed = newValue!;
                    });
                  },
                  items: breeds.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Apply'),
              onPressed: () {
                setState(() {
                  _selectedMaxAge = tempMaxAge;
                  _selectedMinPrice = tempMinPrice;
                  _selectedMaxPrice = tempMaxPrice;
                  _selectedGender = tempGender;
                  _selectedBreed = tempBreed;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
// Inside HomePage class
    List<Pet> filteredPets = PetFilter.filterPets(
      pets: samplePets,
      searchText: _searchController.text,
      maxAge: _selectedMaxAge,
      minPrice: _selectedMinPrice,
      maxPrice: _selectedMaxPrice,
      gender: _selectedGender,
      breed: _selectedBreed,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'Pawfect Match 🐾',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'Search pets...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) => setState(() {}),
            ),
          ),
          Expanded(
            child: filteredPets.isEmpty
                ? const Center(
                    child: Text(
                      'No pets found 🐾🐾.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPets.length,
                    itemBuilder: (context, index) {
                      final pet = filteredPets[index];
                      bool isAdopted = pet.isAdopted;
                      return InkWell(
                        onTap: pet.isAdopted
                            ? null
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsScreen(pet: pet),
                                  ),
                                );
                              },
                        child: Hero(
                          tag: 'petHero-${pet.id}',
                          child: Card(
                            elevation: 8,
                            margin: const EdgeInsets.all(8.0),
                            color: isAdopted
                                ? (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300)
                                : (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black
                                    : Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: isAdopted
                                        ? MediaQuery.of(context).size.width *
                                            0.19 *
                                            0.45
                                        : MediaQuery.of(context).size.width *
                                            0.29 *
                                            0.45,
                                    backgroundImage: NetworkImage(pet.imageUrl),
                                    onBackgroundImageError:
                                        (exception, stackTrace) =>
                                            const Text('No Image is found!'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "I'm ${pet.name}${isAdopted ? ' (Already Adopted)' : ''}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: isAdopted
                                                ? (Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.grey.shade800
                                                    : Colors.grey.shade300)
                                                : (Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                        pet.age > 1
                                            ? Text('Age: ${pet.age} years')
                                            : Text('Age: ${pet.age} year'),
                                        Text('Breed: ${pet.breed}'),
                                        Text('Price: ₹${pet.price}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class PetFilter {
  static List<Pet> filterPets({
    required List<Pet> pets,
    required String searchText,
    required double maxAge,
    required double minPrice,
    required double maxPrice,
    required String gender,
    required String breed,
  }) {
    return pets.where((pet) {
      return pet.name.toLowerCase().contains(searchText.toLowerCase()) &&
          pet.age <= maxAge &&
          pet.price >= minPrice &&
          pet.price <= maxPrice &&
          (gender == 'All' ||
              pet.gender.toLowerCase() == gender.toLowerCase()) &&
          (breed == 'All' || pet.breed.toLowerCase() == breed.toLowerCase());
    }).toList();
  }
}
