class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  int? age;
  String? phone;
  String? imageUrl;
  //creating address object's instance'
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
        //to call the address object's constructor
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


// Map<String, dynamic> addressJson = {'city': 'New York'};
// Address address = Address.fromJson(addressJson);

// print(address.city); // Output: New York


// json['address'] → Extracts the JSON part for address (e.g., {'city': 'New York'}).
// != null → Ensures address exists in JSON.
// Address.fromJson(json['address']) → Converts the JSON to an Address object.
// If address doesn’t exist, assign null.