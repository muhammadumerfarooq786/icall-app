import 'package:flutter/material.dart';
// import 'package:icall/Model/login_user_response_model.dart';
import 'package:icall/Model/user_all_posts_model.dart';
import 'package:icall/services/api_service.dart';
import 'dart:convert';
import 'dart:async';

// import 'package:icall/services/shared_service.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ! Declaration variable
  var index = 0;
  var color = Colors.blue;
  late TabController myControler;
  var like = Colors.black;
  var like2 = Colors.black;
  var likeComent = Colors.black;
  var likenumber = 45;
  var likenumber2 = 117;
  var likeGroups = 22;
  late var size, width, height;
  String UserPosts = '';

  Future<List<UserAllPostsModel>> convertToJson() async {
    List myMap = jsonDecode(UserPosts);
    List<UserAllPostsModel> myPosts = [];

    myMap.forEach((dynamic post) {
      UserAllPostsModel myPost = UserAllPostsModel.fromJson(post);
      myPosts.add(myPost);
    });
    return myPosts.reversed.toList();
    // return myPosts;
  }

  Future readJsonFile() async {
    APIService.PostDetails().then((response) {
      setState(() {
        UserPosts = response;
      });
      if (response != "") {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Success!!')),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error While Fetching Posts!!')),
        );
      }
    });
  }

  @override
  void initState() {
    readJsonFile();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Container(
      child: userProfile(),
    );
  }

  Widget userProfile() {
    return FutureBuilder(
        future: convertToJson(),
        builder: (BuildContext context,
            AsyncSnapshot<List<UserAllPostsModel>> posts) {
          return ListView.builder(
              itemCount: (posts.data == null) ? 0 : posts.data!.length,
              itemBuilder: (BuildContext context, int position) {
                return Container(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black,

                            // image: DecorationImage(
                            //     image: AssetImage("assets/umer.jpeg"),
                            //     fit: BoxFit.cover)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 18),
                            child: Text(
                              posts.data![position].userName
                                  .toString()[0]
                                  .toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        subtitle: Container(
                          child: Text(
                            "Category: " +
                                posts.data![position].category.toString() +
                                "   Location: " +
                                posts.data![position].cityName.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 11),
                          ),
                        ),
                        title: Text("\n" +
                            posts.data![position].userName
                                .toString()
                                .toUpperCase() +
                            " - " +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .year
                                .toString() +
                            "-" +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .month
                                .toString() +
                            "-" +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .day
                                .toString() +
                            "  " +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .hour
                                .toString() +
                            ":" +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .minute
                                .toString() +
                            ":" +
                            DateTime.parse(
                                    posts.data![position].timestamp.toString())
                                .second
                                .toString()),

                        // subtitle: Text(posts.data![position].description.toString()),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: double.infinity,
                        //color: Colors.red,
                        child: Text(
                          posts.data![position].description.toString(),
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          child: Image.network(posts.data![position].file!)),
                      Container(
                        width: width,
                        height: 1,
                        margin: EdgeInsets.only(top: 10),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
