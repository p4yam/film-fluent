
class MovieFilterModel{
  final String slug,name;

  MovieFilterModel(this.slug, this.name);

  static List<MovieFilterModel> get sampleList =>[
    MovieFilterModel('popularity.desc', 'Most Popular'),
    MovieFilterModel('popularity.asc', 'Least Popular'),
    MovieFilterModel('release_date.desc', 'Newest Movies'),
    MovieFilterModel('release_date.asc', 'Oldest Movies'),
    MovieFilterModel('vote_average.desc', 'Highest Votes'),
    MovieFilterModel('vote_average.asc', 'Lowest Votes'),
  ];
}