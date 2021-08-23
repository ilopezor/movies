
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';
import 'package:movies/models/now_playing_response.dart';
import 'package:movies/models/search_movie_response.dart';


class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '1865f43a0549ca50d341dd9ab8b29f49';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;

  MoviesProvider(){
    this.getOnDisplayMovies();
    this.getPopularesMovie();
    // this.getCreditsMovie();
  }

  Future<String> _getJsonData(String segment, [int page = 1]) async{
    var url = Uri.https(_baseUrl, segment, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page'
    });
    // print(url);
    
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData =await _getJsonData('/3/movie/now_playing');
    // print(response);
    final nowPlayingResponse =  NowPlayingResponse.fromJson(jsonData);

    // print( nowPlayingResponse);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularesMovie() async {
    _popularPage++;
    final jsonData =await _getJsonData('/3/movie/popular',_popularPage);

    // print(response);
    final popularResponse =  PopularResponse.fromJson(jsonData);

    // print( nowPlayingResponse);
    popularMovies =[...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future <List<Cast>> getCreditsMovie(int movieId) async {

    if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    // print(jsonData);
    final creditsResponse =  CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    // print(moviesCast[movieId]);
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_baseUrl, '/3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query': query
    });

    final response = await http.get(url);
    // print(response.body);
    final searchResponse = SearchMovieResponse.fromJson( response.body);

    return searchResponse.results;
  }

}