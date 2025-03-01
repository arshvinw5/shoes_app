import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/helper/product_db_helper.dart';
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

  //to get the products from get method\

  List<Products> productsList = [];
  Products? _selectedProduct;

  @override
  void initState() {
    super.initState();
    ProductDbHelper.instance.getProductsList().then((onValue) {
      //use setState to update the list every time
      setState(() {
        //to update the list to make a list builder
        productsList = onValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context).getDarkTheme;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                if (productsList.isEmpty) {
                  return Center(
                      child: Text(
                    'No Products',
                    style: TextStyle(
                        color: themeState ? Colors.white : Colors.black),
                  ));
                } else {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: themeState
                            ? const Color(0xfffef9f3)
                            : const Color(0xFF000000),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                          title: Text(productsList[index].name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color:
                                      themeState ? Colors.black : Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(
                            'LKR ${productsList[index].price.toString()}',
                            style: TextStyle(
                                color: themeState ? Colors.black : Colors.white,
                                fontSize: 15.0),
                          ),
                          trailing: Container(
                            width: 100.0,
                            child: Wrap(
                              direction: Axis.horizontal,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedProduct = productsList[index];
                                        showProductDialogBox(
                                            context,
                                            themeState
                                                ? const Color(0xFF000000)
                                                : const Color(0xfffef9f3),
                                            InputType.UpdateProduct);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: themeState
                                          ? Colors.black
                                          : Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          )),
                    ),
                  );
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showProductDialogBox(
              context,
              themeState ? const Color(0xFF000000) : const Color(0xfffef9f3),
              InputType.AddProduct);
        },
        backgroundColor: themeState ? Colors.white : Colors.black,
        child: Icon(
          Icons.add,
          color: themeState ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  showProductDialogBox(BuildContext context, themeState, InputType type) {
    bool isUpdateProduct = false;

    isUpdateProduct = (type == InputType.UpdateProduct) ? true : false;

    if (isUpdateProduct) {
      _nameController.text = _selectedProduct!.name ?? '';
      _priceController.text = _selectedProduct!.price.toString();
      _quantityController.text = _selectedProduct!.quantity.toString();
    }
    Widget saveButton = ElevatedButton(
      onPressed: () {
        if (_nameController.text.isNotEmpty &&
            _priceController.text.isNotEmpty &&
            _quantityController.text.isNotEmpty) {
          if (isUpdateProduct) {
            setState(() {
              _selectedProduct?.name = _nameController.text;
              _selectedProduct?.price = double.parse(_priceController.text);
              _selectedProduct?.quantity = int.parse(_quantityController.text);
              ProductDbHelper.instance
                  .updateProduct(_selectedProduct!)
                  .then((onValue) {
                ProductDbHelper.instance.getProductsList().then((onValue) {
                  //use setState to update the list every time
                  this.setState(() {
                    //to update the list to make a list builder
                    productsList = onValue;
                  });
                });
                Navigator.of(context).pop();
                _emptyTextFields();
              });
            });
          } else {
            setState(() {
              Products products = Products();
              products.name = _nameController.text;
              //to convert string to double
              products.price = double.parse(_priceController.text);
              //to convert string to int
              products.quantity = int.parse(_quantityController.text);

              ProductDbHelper.instance.insertProduct(products).then((onValue) {
                ProductDbHelper.instance.getProductsList().then((onValue) {
                  //use setState to update the list every time
                  this.setState(() {
                    //to update the list to make a list builder
                    productsList = onValue;
                  });
                });
                Navigator.of(context).pop();
                _emptyTextFields();
              });
            });
          }
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
      title: Text(isUpdateProduct ? 'Update product' : 'Add new product'),
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

  void _emptyTextFields() {
    _nameController.text = '';
    _priceController.text = '';
    _quantityController.text = '';
  }
}

enum InputType { AddProduct, UpdateProduct }
