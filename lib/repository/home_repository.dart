

import 'package:mvvm/model/movies_model.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../res/app_urls.dart';

class HomeRepository {

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> fetchMoviesList() async {

    try{

      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesListEndPoint);
      return response =MovieListModel.fromJson(response);

    }catch(e){
      throw e;
    }
  }
}