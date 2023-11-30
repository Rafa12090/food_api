
String getId(String url) {
  String id = RegExp(r'https://pokeapi.co/api/v2/pokemon/([^]*?)/')
      .firstMatch(url)?[1] as String;
  return id;
}