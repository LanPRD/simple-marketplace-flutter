import 'package:greengrocer/models/product.dart';
import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/models/user.dart';
import 'package:greengrocer/models/order.dart';

Product apple = Product(
  description:
      'A melhor maçã da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
  imageUrl: 'assets/fruits/apple.png',
  itemName: 'Maçã',
  price: 5.5,
  unit: 'kg',
);

Product grape = Product(
  imageUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

Product guava = Product(
  imageUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

Product kiwi = Product(
  imageUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

Product mango = Product(
  imageUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

Product papaya = Product(
  imageUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

List<Product> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  'Frutas',
  'Graõs',
  'Verduras',
  'Temperos',
  'Cereais'
];

// List<CartProduct> cartProducts = [
//   CartProduct(product: apple, quantity: 2),
//   CartProduct(product: mango, quantity: 1),
//   CartProduct(product: guava, quantity: 3),
// ];

User user = User(
  phone: '99 9 9999-9999',
  cpf: '999.999.999-99',
  email: 'allan@gmail.com',
  name: 'Allan Prado',
  password: '',
);

List<Order> orders = [
  // Pedido 01
  // Order(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdAt: DateTime.parse(
  //     '2023-06-08 10:00:10.458',
  //   ),
  //   expiredAt: DateTime.parse(
  //     '2023-06-08 11:00:10.458',
  //   ),
  //   id: 'asd6a54da6s2d1',
  //   status: 'pending_payment',
  //   total: 11.0,
  //   items: [
  // CartProduct(
  //   product: apple,
  //   quantity: 2,
  // ),
  // CartProduct(
  //   product: mango,
  //   quantity: 2,
  // ),
  // ],
  // ),

  // Pedido 02
  // Order(
  //   copyAndPaste: 'q1w2e3r4t5y6',
  //   createdAt: DateTime.parse(
  //     '2023-06-08 10:00:10.458',
  //   ),
  //   expiredAt: DateTime.parse(
  //     '2023-06-08 11:00:10.458',
  //   ),
  //   id: 'a65s4d6a2s1d6a5s',
  //   status: 'delivered',
  //   total: 11.5,
  //   items: [
  // CartProduct(
  //   product: guava,
  //   quantity: 1,
  // ),
  // ],
  // ),
];
