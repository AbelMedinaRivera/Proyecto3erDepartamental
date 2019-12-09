import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_kart/model/Product.dart';
import 'package:flutter_kart/model/hotel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsModel extends Model {
  List<Hotel> _hotelList = [];
  List<Product> _products = [];
  List<Product> _cartList = [];
  final baseUrl = 'http://api.flutterapp.in/api/';

  ProductsModel() {
    _products.add(Product(
      'Glucosamina + condroitina + MSN 90 Caps',
      'Celaborada con Vcaps (cápsulas de origen vegetal)',
      300,
      'https://images-na.ssl-images-amazon.com/images/I/71BHPMY5zzL._SL1500_.jpg',
    ));

    _products.add(Product(
      'L-CARNITINA CAPSULE',
      '1,200 100 caps',
      200,
      'https://images-na.ssl-images-amazon.com/images/I/71OQa58uGxL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Forzagen Proteina Vegana Orgánica',
      'Vegetal, Orgánica, Importada, 100% Natural ',
      500,
      'https://images-na.ssl-images-amazon.com/images/I/71AHZk9WEAL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Bio B 60',
      'cápsulas Moringa',
      120,
      'https://images-na.ssl-images-amazon.com/images/I/71gxNItvuLL._SL1500_.jpg',
    ));

    _products.add(Product(
      'Optimum Nutrition 100% ',
      'Whey Gold Standard',
      450,
      'https://images-na.ssl-images-amazon.com/images/I/71Z3sns2bpL._SL1500_.jpg',
    ));

    _products.add(Product(
      'CASEC',
      'CrazyMuscle',
      190,
      'https://images-na.ssl-images-amazon.com/images/I/61xJIhNFp%2BL._SL1472_.jpg',
    ));

    _hotelList.add(Hotel(
        'Amazon',
        'https://logodownload.org/wp-content/uploads/2014/04/amazon-logo.png',
        'USA',
        '2-5 dias',
        4.8,
        500));

    _hotelList.add(Hotel(
        'Mercado Libre',
        'https://hs.bind.com.mx/hubfs/2.0/Marketplace/Logo/Mercado-Libre-Logo-Horizontal.png',
        'Mexico',
        '3-5 dias',
        4.3,
        500));
  }

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get getCartList {
    return List.from(_cartList);
  }

  List<Hotel> get getHotelList {
    return List.from(_hotelList);
  }

  double get getCartPrice {
    double price = 0;
    getCartList.forEach((Product pro) {
      price += pro.price;
    });
    return price;
  }

  void addProduct(Product product) {
    final Map<String, dynamic> productMap = {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'image':
          'https://www.dinneratthezoo.com/wp-content/uploads/2016/10/veggie-fried-rice-6-500x500.jpg',
    };

    http.post(
      baseUrl + 'products',
      body: json.encode(productMap),
      headers: {
        'Content-Type': 'application/json',
      },
    ).then(
      (response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      },
    );
    _products.add(product);
    notifyListeners();
  }

 getProductList() async {
  final data = await  http
        .get(
      baseUrl + 'products',
    )
        .then(
      (response) {
       
      },
    );
    
  }

  void addToCart(Product product) {
    _cartList.add(product);
    notifyListeners();
  }
}
