
class ErrorModel implements Exception{
  final int id;
  final String message;

  ErrorModel({this.id, this.message});

}