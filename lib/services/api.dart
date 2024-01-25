import 'dart:convert';

import 'package:dio/dio.dart';

//const baseUrl = 'http://192.168.180.190:80';
const baseUrl = 'http://192.168.247.190:80';

void turnOnLed(bool status, int ledNum) async {
  Map statusMap = {true: "on", false: "off"};

  var dio = Dio();
  // ignore: prefer_interpolation_to_compose_strings
  var url = '$baseUrl/led${statusMap[status]}$ledNum';
  Response? response;
  try {
    //url = 'http://192.168.180.190:80/fan/$st';
    print(url);
    response = await dio.get(url);
  } catch (e) {
    print(e);
  }

  Map mp = {
    'url': url,
    'statusCode': response!.statusCode,
  };

  print(mp);
}

Future<double> fetchTemperature() async {
  var url = '$baseUrl/temperature';
  var dio = Dio();
  Response? response;
  try {
    //url = 'http://192.168.180.190:80/fan/$st';
    print(url);
    response = await dio.get(url);

    print('temperature data: ${response.data}');
    if (response.statusCode == 200) {
      //double val = double.parse(response.data);

      //return json.decode(response.data);
      //return val.toInt();
      return double.parse(response.data);
    }
  } catch (e) {
    print(e);
  }

  Map mp = {
    'url': url,
    'statusCode': response!.statusCode,
  };

  print(mp);

  return 0;
}

Future<String> fetchFireStatus() async {
  String fireStatus = '';
  var url = '$baseUrl/firestatus';
  var dio = Dio();
  Response? fireResponse;

  Map fireState = {
    'No fire detected': 'safe',
    'Fire detected': 'FIRE',
    null: 'off',
  };
  try {
    //url = 'http://192.168.180.190:80/fan/$st';
    print(url);
    fireResponse = await dio.get(url);

    print('fire data: ${fireResponse.data}');
    if (fireResponse.statusCode == 200) {
      //fireStatus = fireResponse.data;
      fireStatus = fireState[fireResponse.data];
    }
  } catch (e) {
    print(e);
  }

  Map mp = {
    'url': url,
    'statusCode': fireResponse!.statusCode,
    'data': fireStatus,
  };

  print(mp);
  return fireStatus;
  //return finalFireState;
}

Future<String> fetchFanStatus() async {
  String fanStatus = '';

  Map fanState = {
    'Fan is ON': 'on',
    'Fan is Off': 'off',
    null: 'off',
  };

  var finalFanState;

  var url = '$baseUrl/fanstatus';
  var dio = Dio();
  Response? response;
  try {
    response = await dio.get(url);
    print('fan data: ${response.data}');
    if (response.statusCode == 200) {
      var data = response.data;
      print('fan data is null? ${response.data}');
      if (data == 'Fan is ON') {
        finalFanState = 'on';
      } else if (data == 'Fan is Off') {
        finalFanState == 'off';
      } else if (double.tryParse(data) is double) {
        print('it came here');
        double numValue = double.parse(data);
        print(numValue.toString());
        if (numValue > 27.0) {
          finalFanState = 'on';
        } else {
          finalFanState = 'off';
        }
      }
      fanStatus = fanState[response.data];
      print('fan status: $fanStatus');
    }
  } catch (e) {
    print(e);
  }

  Map mp = {
    'url': url,
    'statusCode': response!.statusCode,
    'data': fanStatus,
  };

  print(mp);
  //return fanStatus;
  return finalFanState;
}
