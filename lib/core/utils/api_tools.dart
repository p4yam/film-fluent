
import 'package:get/get.dart';

class ApiTools extends GetConnect{
   Future<Response> getRequest(String baseUrl,String apiPath, Map<String,dynamic> query)=>get(baseUrl+apiPath,query: query);
}