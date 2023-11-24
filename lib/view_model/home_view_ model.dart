

import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    moviesList = response;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi() async {
    _myRepo.fetchMoviesList().then((value) {

    }).onError((error, stackTrace){

    });
  }
}