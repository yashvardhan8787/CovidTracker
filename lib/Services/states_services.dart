import "dart:convert";

import "package:covid_tracker_app/Services/Utitlies/app_url.dart";
import "package:http/http.dart" as http ;

import "../Model/world_states_model.dart";


class StatesServices {


  Future<WorldStatesModel> fetchWorlStatesRecords () async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    }else{
      throw Exception("error");
    }
  }

  Future<List<dynamic>> fetchCountriesList () async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("error");
    }
  }
}

