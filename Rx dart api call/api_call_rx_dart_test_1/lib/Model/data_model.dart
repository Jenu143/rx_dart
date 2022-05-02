class DataModel {
  late int page;
  late List results;
  late int totalPages;
  late int totalResults;

  DataModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    page = json["page"];
    totalPages = json["total_pages"];
    totalResults = json["total_results"];

    //* null cheack for result list
    if (json["results"] != null) {
      results = <Results>[];

      json["results"].forEach((e) {
        results.add(Results.fromJson(e));
      });
    }
  }
}

class Results {
  late bool adult;
  late String backdropPath;
  late List genreIds;
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late num popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late bool video;
  late double voteAverage;
  late int voteCount;

  Results({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json["adult"];
    backdropPath = json["backdrop_path"];
    id = json["id"];
    originalLanguage = json["original_language"];
    originalTitle = json["original_title"];
    overview = json["overview"];
    popularity = json["popularity"];
    posterPath = json["poster_path"];
    releaseDate = json["release_date"];
    title = json["title"];
    video = json["video"];
    voteAverage = double.parse("${json["vote_average"]}");
    voteCount = json["vote_count"];
    genreIds = json["genre_ids"];
  }
}
