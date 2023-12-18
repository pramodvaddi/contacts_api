import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_one/theme/colors.dart';
import 'package:http/http.dart' as http;

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    var url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)["results"];
      setState(() {
        users = items;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Users"),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    // List items = ['1', '2'];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(index) {
    var countryHeading = 'Country';
    var emailHeading = 'EMail';
    var birthHeading = 'DOB';
    var fullName = index['name']['last'];
    var country = index['location']['country'];
    var email = index['email'];
    var birth = index['dob']['date'];
    var profileurl = index['picture']['large'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: ListTile(
          tileColor: white,
          title: Row(children: <Widget>[
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(profileurl.toString()),
                      ),
                      ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fullName.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  countryHeading,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  country.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  emailHeading,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  email.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
                Text(
                  birthHeading,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  birth.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
