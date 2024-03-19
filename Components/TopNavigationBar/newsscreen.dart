import 'package:flutter/material.dart';
import 'package:icall/Model/admin_news_model.dart';
import 'package:icall/services/api_service.dart';
import 'dart:convert';
import 'dart:async';
import 'package:icall/services/shared_service.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
  String AdminPosts = '';

  Future<List<AdminNewsModel>> convertToJson() async {
    List myMap = jsonDecode(AdminPosts);
    List<AdminNewsModel> myPosts = [];

    myMap.forEach((dynamic post) {
      AdminNewsModel myPost = AdminNewsModel.fromJson(post);
      myPosts.add(myPost);
    });
    return myPosts;
  }

  Future readJsonFile() async {
    APIService.NewsDetails().then((response) {
      setState(() {
        AdminPosts = response;
      });
      if (response != "") {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Success!!')),
        // );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error While Fetching News!!')),
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
        builder:
            (BuildContext context, AsyncSnapshot<List<AdminNewsModel>> posts) {
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
                            padding: EdgeInsets.only(top: 12, left: 18),
                            child: Text(
                              "A",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        subtitle: Container(
                          child: Text(
                            "Location: " +
                                posts.data![position].location.toString() +
                                "   Published By: " +
                                posts.data![position].userName.toString(),
                            style: TextStyle(color: Colors.green, fontSize: 11),
                          ),
                        ),
                        title: Text("\n" +
                            posts.data![position].subject.toString() +
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
