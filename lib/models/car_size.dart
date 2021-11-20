class CarSize{

  CarSize.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  CarSize(/*String g, String a, String l*/);

   String? name;
   num? price;
   int? stock;

  bool get hasStock => stock! > 0;

  @override
  String toString() {
    return 'CarSize{name: $name, price: $price, stock: $stock}';
  }
}