import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/read%20data/get_user_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final user = FirebaseAuth.instance.currentUser!;
  //document IDs
  List<String> docIds = [];
  //get docIds
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIds.add(document.reference.id);
            }));
  }

  @override
  void initState() {
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Icon(Icons.logout))
          ],
          centerTitle: true,
          title: Text(
            user.email!,
            style: GoogleFonts.rubik(
                textStyle: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        drawer: NavigationDrawer(),
        body: Column(children: [
          // Text("signed in as: " + user.email!),
          Expanded(
              child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIds.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        title: GetUserName(documentId: docIds[index]),
                      ),
                    );
                  });
            },
          ))
        ]),
      ),
    );
  }
}

//drawer
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            builderHeader(context),
            builderMenuItems(context),
          ],
        )),
      );
  Widget builderHeader(BuildContext context) => Container(
        color: Colors.deepPurple[200],
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(children: [
          CircleAvatar(
            radius: 52,
          ),
          SizedBox(
            height: 12,
          ),
          Text("data"),
          Text("emails")
        ]),
      );
  Widget builderMenuItems(BuildContext context) => Container(
        padding: EdgeInsets.all(24),
        child: Wrap(
          // runSpacing: 16,
          children: [
            ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text("Home"),
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => home()))),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("favourities"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("people"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("edit"),
              onTap: () {},
            ),
            Divider(
              color: Colors.black54,
            ),
            ListTile(
              leading: Icon(Icons.home_outlined),
              title: Text("Home"),
              onTap: () {},
            ),
          ],
        ),
      );
}
