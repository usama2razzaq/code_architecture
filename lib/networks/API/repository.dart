import 'package:assignment/networks/API/api_base_helper.dart';
import 'package:assignment/networks/API/exceptions.dart';
import 'package:assignment/networks/data_model/movie_details_response.dart';
import 'package:assignment/networks/data_model/moivie_response.dart';

import '../../api/api_key.dart';

class Repository {
  //Api Helper to method
  ApiBaseHelper helper = ApiBaseHelper();

  Future<MovieList> getMovie(
      {int? page, int? pageSize, String? startDate, String? endDate}) async {
    try {
      final response = await helper
          .get('3/movie/popular?api_key=$rawgApiKey&language=en-US&page=$page');

      return MovieList.fromJson(response);
    } catch (exception) {
      print(exception.toString());
      throw ServerException(message: exception.toString());
    }
  }

//get movie details from REST API
  Future<MovieDetails> getMovieDetails({int? id}) async {
    try {
      final response =
          await helper.get('3/movie/$id?api_key=$rawgApiKey&language=en-US');

      return MovieDetails.fromJson(response);
    } catch (exception) {
      print(exception.toString());

      throw ServerException(message: exception.toString());
    }
  }
}
