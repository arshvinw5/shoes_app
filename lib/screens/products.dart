import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/model/products.dart';
import 'package:shoes_app/providers/dark_theme_provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<ProductsScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;

    return Scaffold(
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showProductDialogBox(context,
              themeState ? const Color(0xFF000000) : const Color(0xfffef9f3));
        },
        backgroundColor: themeState ? Colors.white : Colors.black,
        child: Icon(
          Icons.add,
          color: themeState ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  showProductDialogBox(BuildContext context, themeState) {
    Widget saveButton = ElevatedButton(
      onPressed: () {
        if (_nameController.text.isNotEmpty &&
            _priceController.text.isNotEmpty &&
            _quantityController.text.isNotEmpty) {
          Products products = Products();
          products.name = _nameController.text;
          //to convert string to double
          products.price = double.parse(_priceController.text);
          //to convert string to int
          products.quantity = int.parse(_quantityController.text);
          Navigator.of(context).pop();
        }
      },
      child: Text('Save'),
    );

    Widget cancelButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'),
    );

    AlertDialog productDialogBox = AlertDialog(
      title: Text('Add new product'),
      backgroundColor: themeState,
      content: Container(
        child: Wrap(
          children: [
            Container(
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Product Price'),
              ),
            ),
            Container(
              child: TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Product quntity'),
              ),
            )
          ],
        ),
      ),
      actions: [saveButton, cancelButton],
    );

    showDialog(context: context, builder: (context) => productDialogBox);
  }
}
