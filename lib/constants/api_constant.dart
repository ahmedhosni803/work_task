class ApiConstant {
  static const String baseUrl = "https://api.themoviedb.org/3/";
  static const String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZTc4NzU0ODY2ZDUwZTY4MjFmMzhlNDc5ODg1MGU4MyIsInN1YiI6IjY1NjdjM2RjODlkOTdmMDBhYjE2OTdiNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.YRBaqUgAxy96TttB4XMtnT5DreWR1D3osoMUlie0CDU";

  ///End Points
  static const String popular = "person/popular";
  static String personDetails(String id) => "person/$id";
  static String images(String personId) => "person/$personId/images";
}

enum Gender { male, female }
