import 'package:flutter/material.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  // ignore: prefer_final_fields
  var _imageUrlInput = '';
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', descreption: '', price: 0, imageUrl: '');

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
  }

  void _saveform() {
    _form.currentState!.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.descreption);
    print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Edit Products',
        ),
        actions: [
          IconButton(onPressed: _saveform, icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Title',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (v) {
                      _editedProduct = _editedProduct.copyWith(title: v);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                      suffixIcon: Icon(Icons.attach_money_rounded),
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (v) {
                      _editedProduct = _editedProduct.copyWith(
                          price: double.parse(v as String));
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    focusNode: _descriptionFocusNode,
                    onSaved: (v) {
                      _editedProduct = _editedProduct.copyWith(descreption: v);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        margin: const EdgeInsets.all(8),
                        child: _imageUrlController.text.isEmpty
                            ? const Center(
                                child: Text('Add URL'),
                              )
                            : Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/product_background.png',
                                    height: 120,
                                  ),
                                  Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.contain,
                                    height: 90,
                                  ),
                                ],
                                alignment: Alignment.center,
                              ),
                      ),
                      Expanded(
                          child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Product Image URL',
                          helperText: 'Use PNG Images',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        onChanged: (value) {
                          setState(() {
                            value = _imageUrlInput;
                          });
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onSaved: (v) {
                          _editedProduct = _editedProduct.copyWith(imageUrl: v);
                        },
                        onFieldSubmitted: (v) {
                          _saveform();
                        },
                      ))
                    ],
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: _saveform,
          style: ButtonStyle(
              fixedSize:
                  MaterialStateProperty.all<Size>(const Size.fromWidth(150)),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).colorScheme.secondaryVariant),
              elevation: MaterialStateProperty.all<double>(7),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10))),
          child: Row(
            children: [
              Icon(
                Icons.done_rounded,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Save Product',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              )
            ],
          )),
    );
  }
}
