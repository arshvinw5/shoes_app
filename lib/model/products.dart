class Products {
  int? id;
  String? name;
  String? description;
  double? price;
  String? imageUrl;
  int? quantity;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.imageUrl,
      this.quantity});

  ///from map  Map=>product object
  static Products fromMap(Map<String, dynamic> query) {
    Products products = Products();
    products.id = query['id'];
    products.name = query['name'];
    products.description = query['description'];
    products.price = query['price'];
    products.imageUrl = query['imageUrl'];
    products.quantity = query['quantity'];
    return products;
  }

  /// to map product object => Map
  static Map<String, dynamic> toMap(Products products) {
    return <String, dynamic>{
      'id': products.id,
      'name': products.name,
      'description': products.description,
      'price': products.price,
      'imageUrl': products.imageUrl,
      'quantity': products.quantity
    };
  }

  //to add product to list
  static List<Products> fromList(List<Map<String, dynamic>> query) {
    List<Products> products = [];
    for (Map<String, dynamic> mp in query) {
      products.add(fromMap(mp));
    }
    return products;
  }
}
