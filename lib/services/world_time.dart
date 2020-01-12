import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; //location name for UI
  String time; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for api endpoints
  bool isDayTime; //true or false if daytime or not

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get ('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get property from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      int minutes;
      data['raw_offset'] == 19800 ? minutes = 30 : minutes = 00;
      //print(datetime);
      //print(offset);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: minutes));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'Could Not Get Time Data, Please Ensure that you have Selected Correct Country and City';
    }



  }


}