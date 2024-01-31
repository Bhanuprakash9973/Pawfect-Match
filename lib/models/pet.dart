class Pet {
  final String id;
  final String name;
  final int age;
  final double price;
  final String breed;
  final String gender;
  bool isAdopted;
  final String imageUrl;
  DateTime? adoptedDate;

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.breed,
    required this.gender,
    this.isAdopted = false,
    required this.imageUrl,
    this.adoptedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'price': price,
      'breed': breed,
      'gender': gender,
      'isAdopted': isAdopted ? 1 : 0,
      'imageUrl': imageUrl,
      'adoptedDate': adoptedDate?.toIso8601String(),
    };
  }

  static Pet fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      price: map['price'],
      breed: map['breed'],
      gender: map['gender'],
      isAdopted: map['isAdopted'] == 1,
      imageUrl: map['imageUrl'],
      adoptedDate: map['adoptedDate'] != null
          ? DateTime.parse(map['adoptedDate'])
          : null,
    );
  }
}
