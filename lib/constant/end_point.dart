class EndPoint {
  static const String popular = "person/popular";
  static String personDetails(String id) => "person/$id";
  static String images(String personId) => "person/$personId/images";
}
