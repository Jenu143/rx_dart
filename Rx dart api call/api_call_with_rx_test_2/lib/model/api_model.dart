class ApiModel {
  late int page;
  late List<Results> results;
  late int totalPages;
  late int totalResults;

  ApiModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  ApiModel.fromJson(Map<String, dynamic> json) {
    page = json["page"];

    //* for result list
    if (json["results"] != null) {
      results = <Results>[];

      json["results"].forEach((a) {
        results.add(Results.fromJson(a));
      });
    }
    totalPages = json["total_pages"];
    totalResults = json["total_results"];
  }
}

class Results {
  late bool adult;
  late String backDropPath;
  late List genreIds;
  late int id;
  late String originalLang;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String postarPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Results({
    required this.adult,
    required this.backDropPath,
    required this.genreIds,
    required this.id,
    required this.originalLang,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.postarPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backDropPath = json["backdrop_path"];
    genreIds = json["genre_ids"];
    id = json["id"];
    originalLang = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    postarPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = double.parse("${json["vote_average"]}");
    voteCount = json["vote_count"];
  }
}

class CustomApiProvider<T> {
  int? statusCode;
  T? data;

  CustomApiProvider({
    this.statusCode,
    this.data,
  });

  CustomApiProvider.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    statusCode = json['status'];
  }
}
