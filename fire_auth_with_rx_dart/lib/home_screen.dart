import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_auth_with_rx_dart/View/Login/login_screen.dart';
import 'package:fire_auth_with_rx_dart/block/auth_block.dart';
import 'package:fire_auth_with_rx_dart/constant/colors.dart';
import 'package:fire_auth_with_rx_dart/constant/strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.resUid,
  }) : super(key: key);
  final String resUid;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthBlock _authBlock = AuthBlock();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getUserList();

    super.initState();
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('collectionPath');

  Future<List<Object?>> getUserList() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;

    // print(allData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.homeString,
              style: TextStyle(
                color: ColorName.greyColor.withOpacity(0.6),
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: getUserList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data[index]["name"]);
                        return Column(
                          children: [
                            Text("${snapshot.data[index]["name"]}"),
                          ],
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Welcome"),
      centerTitle: true,
      leadingWidth: 100,
      leading: ElevatedButton(
        onPressed: () {
          _authBlock.logOutSink();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
        child: Text(Strings.logOut),
      ),
    );
  }
}
