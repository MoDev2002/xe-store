import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_image.dart';
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
  bool hasInitVal = true;
  var _editedProduct =
      Product(id: '', title: '', descreption: '', price: 0, imageUrl: '');

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (hasInitVal) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != '') {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
      }
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    hasInitVal = false;
  }

  void _saveform() {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Row(children: [
                CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 15),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Loading...'),
                )
              ]),
            ));
    _form.currentState!.save();
    if (_editedProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);

      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .then((_) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
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
                  SizedBox(height: 5),
                  TextFormField(
                    initialValue: _editedProduct.title,
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Product Title.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _editedProduct.price == 0
                        ? null
                        : _editedProduct.price.toString(),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Product Price.';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number.';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Enter a price above zero.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                      initialValue: _editedProduct.descreption,
                      decoration: const InputDecoration(
                        labelText: 'Product Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      onSaved: (v) {
                        _editedProduct =
                            _editedProduct.copyWith(descreption: v);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Product Description.';
                        }
                        if (value.length < 10) {
                          return 'The description length should be at least 10 characters long.';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                          width: 150,
                          height: 150,
                          margin: const EdgeInsets.all(8),
                          child: (_imageUrlController.text.isEmpty ||
                                  (!_imageUrlController.text
                                          .startsWith('http://') &&
                                      !_imageUrlController.text
                                          .startsWith('https://')) ||
                                  (!_imageUrlController.text.contains('.png') &&
                                      !_imageUrlController.text
                                          .contains('.jpg') &&
                                      !_imageUrlController.text
                                          .contains('.jpeg')))
                              ? const Center(
                                  child: Text('Add URL'),
                                )
                              : ProductImage(
                                  imageUrl: _imageUrlController.text,
                                  bgHeight: 120,
                                  imgHeight: 90,
                                  oval: false,
                                )),
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
                            if (value.isEmpty ||
                                (!value.startsWith('http://') &&
                                    !value.startsWith('https://')) ||
                                (!value.contains('.png') &&
                                    !value.contains('.jpg') &&
                                    !value.contains('.jpeg'))) {
                              return;
                            } else {
                              value = _imageUrlInput;
                            }
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Image URL.';
                          }
                          if (!value.startsWith('http://') &&
                              !value.startsWith('https://')) {
                            return 'Enter a valid URL.';
                          }
                          if (!value.contains('.png') &&
                              !value.contains('.jpg') &&
                              !value.contains('.jpeg')) {
                            return 'Enter a valid image URL.';
                          }
                          return null;
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
