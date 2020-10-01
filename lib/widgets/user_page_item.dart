import 'package:flutter/material.dart';
import 'package:random_user/model/user.dart';

class UserPageItem extends StatelessWidget {
  const UserPageItem({Key key, @required this.users,  @required this.index}) : super(key: key);

  final List<User> users;
  final int index;

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.only(left:80.0, right: 80.0,top:20.0,bottom: 20.0),
        child: Container(
          decoration:
         BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(5.0)),
         ),
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 12.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 230.0,
                child: Image.network(users[index].pictureLarge,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(28.0),
                child: Text(
                  users[index].fullName(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                  ),
                ),
              ),
              Text("Address:"),
              SizedBox(
                height: 4.0,
              ),
              Text(users[index].address(),
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text("E-Mail:"),
              SizedBox(
                height: 4.0,
              ),
              Text(users[index].email,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text("Phone:"),
              SizedBox(
                height: 4.0,
              ),
              Text(users[index].phone,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0
                ),
              ),
            ],
        ),
         ),
      ),
    );
  }
}