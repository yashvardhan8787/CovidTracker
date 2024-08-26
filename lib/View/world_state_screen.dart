import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:pie_chart/pie_chart.dart';

class WorldSateScreen extends StatefulWidget {
  const WorldSateScreen({super.key});

  @override
  State<WorldSateScreen> createState() => _WorldSateScreenState();
}

class _WorldSateScreenState extends State<WorldSateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:const  Text("World's Covid Data",style: TextStyle(color: Colors.white ,fontSize: 25,fontWeight:FontWeight.w600,),),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding:const  EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * .01,
                ),
                FutureBuilder(
                    future: statesServices.fetchWorlStatesRecords(),
                    builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases!.toString()),
                                "Recverd":double.parse(snapshot.data!.recovered!.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions:const  ChartValuesOptions(showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions:const  LegendOptions(
                                  legendPosition: LegendPosition.left),
                              animationDuration:const Duration(seconds: 2),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(title: "Total Cases ", value:snapshot.data!.cases!.toString()),
                                    ReusableRow(title: "Total deaths ", value:snapshot.data!.deaths!.toString()),
                                    ReusableRow(title: "Total Recovered ", value: snapshot.data!.recovered!.toString()),
                                    ReusableRow(title: "Today's Cases", value:snapshot.data!.todayCases!.toString()),
                                    ReusableRow(title: "Today's Deaths", value: snapshot.data!.todayDeaths!.toString()),
                                    ReusableRow(title: "Today's Recovered  ", value: snapshot.data!.todayRecovered!.toString()),
                                    ReusableRow(title: "Population ", value:snapshot.data!.population!.toString() ),
                                    ReusableRow(title: "Affected Countries", value: snapshot.data!.affectedCountries!.toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap:()=>{
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>const  CountriesListScreen(),))
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color:const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)),
                                child:const Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider()
      ],
    );
  }
}
