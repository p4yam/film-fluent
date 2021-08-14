import 'package:get/get.dart';

class ApiTools extends GetConnect {

  /// [query] can be added to a get request directly but there is a bug in adding multiple
  /// key values which makes Get package to throw [HttpException], so adding [query] params
  /// to url string was the workaround.
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

