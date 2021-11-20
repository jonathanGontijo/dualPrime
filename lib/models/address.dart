class Address {

  Address({required this.street, required this.district,
    required this.zipCode, required this.city, required this.state, required this.lat, required this.long});

  late String street;
  late String number;
  late String complement;
  late String district;
  late String zipCode;
  late String city;
  late String state;

  late double? lat;
  late double? long;

}