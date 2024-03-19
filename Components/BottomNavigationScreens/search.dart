import 'package:flutter/material.dart';
// import 'package:line_awesome_icons/line_awesome_icons.dart';

class Explore extends StatelessWidget {
  ScrollController _controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image(
          alignment: Alignment.topCenter,
          image: AssetImage("assets/image3.png"),
          fit: BoxFit.contain,
          width: double.infinity,
        ),
        Positioned(
          top: 40,
          left: 30,
          right: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Text(
                "Explore",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'CentraleSansRegular'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 18,
                        fontFamily: 'CentraleSansRegular',
                        fontWeight: FontWeight.w100),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 110),
          height: 300,
          width: 450,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Image.asset("assets/slide1.png"),
              Image.asset("assets/slide2.png"),
              Image.asset("assets/slide3.png")
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 370),
          height: 400,
          width: 400,
          child: ListView(
            controller: _controller,
            children: <Widget>[
              ListTile(
                leading: Image.asset("assets/ad1.png"),
                title: Text("Two Child Education",
                    style: TextStyle(
                        fontFamily: "CentraleSansRegular",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text("Okara",
                    style: TextStyle(
                      fontFamily: "CentraleSansRegular",
                      fontSize: 15,
                    )),
              ),
              ListTile(
                leading: Image.asset("assets/ad2.png"),
                title: Text("10th Grade School Fee",
                    style: TextStyle(
                        fontFamily: "CentraleSansRegular",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text("Lahore",
                    style: TextStyle(
                      fontFamily: "CentraleSansRegular",
                      fontSize: 15,
                    )),
              ),
              ListTile(
                leading: Image.asset("assets/ad3.png"),
                title: Text("Complete School Fee",
                    style: TextStyle(
                        fontFamily: "CentraleSansRegular",
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                subtitle: Text("Islamabad",
                    style: TextStyle(
                      fontFamily: "CentraleSansRegular",
                      fontSize: 15,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
