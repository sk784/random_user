class User {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String state;
  final String city;
  final String street;
  final int houseNumber;
  final String pictureSmall;
  final String pictureLarge;

  User({this.firstName,this.lastName,this.email, this.phone, this.country, this.state, this.city,
    this.houseNumber,this.street, this.pictureSmall,this.pictureLarge});


  static User fromJson(dynamic json) {
    return User(
      email: json['email'] as String,
      firstName: json['name']['first'] as String,
      lastName: json['name']['last'] as String,
      phone: json['phone'] as String,
      country:json['location']['country'] as String,
      state: json['location']['state'] as String,
      city: json['location']['city'] as String,
      houseNumber: json['location']['street']['number'] as int,
      street: json['location']['street']['name'] as String,
      pictureLarge: json['picture']['large'] as String,
      pictureSmall: json['picture']['medium'] as String,
    );
  }


  String fullName(){
    return this.firstName + " " + this.lastName;
  }

  String address(){
    return this.country +", "+this.state + ", "+
        this.city +", "+ this.houseNumber.toString() +" "+this.street;
  }
}