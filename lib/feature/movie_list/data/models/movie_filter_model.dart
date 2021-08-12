
class MovieFilterModel{
  final String slug,name;

  MovieFilterModel(this.slug, this.name);

  static List<MovieFilterModel> get sampleList =>[
    MovieFilterModel('popularity.asc', 'Most Popular'),
    MovieFilterModel('popularity.desc', 'Least Popular'),
    MovieFilterModel('release_date.asc', 'Newest Movies'),
    MovieFilterModel('release_date.desc', 'Oldest Movies'),
    MovieFilterModel('vote_average_asc', 'Highest Votes'),
    MovieFilterModel('vote_average_desc', 'Lowest Votes'),
  ];
}