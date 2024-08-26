import 'package:covid_tracker_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget{
  final String name , totalCases , totalDeaths , totalRecovered ,active , critical ,todayRecovered ,test , image ;
  const DetailScreen({super.key,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
    required this.image,
  });
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height * 0.6,),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height* .067),
                child: Card(
                  child: Column(
                    children: [
                      ReusableRow(title:"Total Cases", value: widget.totalCases),
                      ReusableRow(title:"Total Deaths", value: widget.totalDeaths),
                      ReusableRow(title:"Total Recovered cases", value: widget.totalRecovered),
                      ReusableRow(title:"Total Tests", value: widget.test),
                      ReusableRow(title:"Active Cases", value: widget.active),
                      ReusableRow(title:"Critical Cases", value: widget.critical),
                      ReusableRow(title:"Cases Recovered Today", value: widget.todayRecovered),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius:50 ,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}