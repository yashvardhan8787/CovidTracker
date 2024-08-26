import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget{
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body:SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: searController,
              onChanged: (value){
                setState(() {

                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'search with country name',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),
            ),
            Expanded(
              child:FutureBuilder(
                future:statesServices.fetchCountriesList(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                  if(!snapshot.hasData){
                    return ListView.builder(
                        itemCount:4,
                        itemBuilder: (context , index){
                          return Shimmer.fromColors(
                            baseColor:Colors.grey.shade700 ,
                            highlightColor:Colors.grey.shade100 ,

                            child: Column(
                                children:[
                                  ListTile(
                                    title: Container(height: 10,width: 89, color: Colors.white,),
                                    subtitle:Container(height: 10,width: 89, color: Colors.white,),
                                    leading:Container(height: 50,width: 50, color: Colors.white,),
                                  )
                                ]
                            ),
                          );
                        }
                    );
                  }else{
                    return ListView.builder(
                        itemCount:snapshot.data!.length,
                        itemBuilder: (context , index){
                          String name = snapshot.data![index]['country'];
                          if(searController.text.isEmpty){
                            return Column(
                                children:[
                                  InkWell(
                                    onTap:(){
                                      Navigator.push(context ,MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            active:snapshot.data![index]["active"].toString() ,
                                            critical: snapshot.data![index]['critical'].toString() ,
                                            name:snapshot.data![index]["country"],
                                            test:snapshot.data![index]['tests'] .toString() ,
                                            todayRecovered:snapshot.data![index]['todayRecovered'] .toString(),
                                            totalCases: snapshot.data![index]["cases"].toString(),
                                            totalDeaths:snapshot.data![index]["deaths"].toString(),
                                            totalRecovered:snapshot.data![index]["recovered"].toString(),
                                            image:snapshot.data![index]["countryInfo"]["flag"]  ,
                                          )));
                                   },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                        height: 50,
                                        width: 50,
                                        image: NetworkImage(
                                            snapshot.data![index]['countryInfo']['flag']
                                        ),
                                      ),
                                    ),
                                  )
                                ]
                            );
                          }else if(name.toLowerCase().contains(searController.text.toLowerCase())){
                            return Column(
                                children:[
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  )
                                ]
                            );
                          }else{
                            return Container();
                          }
                    }
                    );
                  }

                },
              ) ,
            )
          ],
        ),
      ),
    );
  }
}