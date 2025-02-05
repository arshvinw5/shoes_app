class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? age;
  String? phone;
  String? imageUrl;
  Address? address;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.age,
    this.phone,
    this.imageUrl,
    this.address,
  });

  // Convert json to a single User object using initializer list.
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        age = json['age'],
        phone = json['phone'],
        imageUrl = json['image'],
        address =
            json['address'] != null ? Address.fromJson(json['address']) : null;

  // Convert User object to json.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
      'phone': phone,
      'image': imageUrl,
      'address': address?.toJson(),
    };
  }
}

class Address {
  String? city;

  Address({this.city});

  Address.fromJson(Map<String, dynamic> json) : city = json['city'];

  Map<String, dynamic> toJson() {
    return {'city': city};
  }
}
