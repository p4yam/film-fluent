import 'package:get/get.dart';

class ApiTools extends GetConnect {
  // Query can be added to a get request but there was a bug in adding multiple key values.
  Future<Response> getRequest(
          String baseUrl, String apiPath, Map<String, dynamic> query) =>
      get(baseUrl + apiPath+_createStringFromMap(query));

    String _createStringFromMap(Map<String,dynamic> query){
      var str ='?';
      query.forEach((key, value) {
        str+='$key=$value&';
      });
      return str;
    }
}

