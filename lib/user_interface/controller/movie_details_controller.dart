import 'package:assignment/networks/API/repository.dart';
import 'package:assignment/networks/data_model/movie_details_response.dart';
import 'package:get/get.dart';

class MovieDetailsController extends GetxController {
  RxBool isLoading = false.obs;

  RxInt id = 0.obs;
  Repository? repository;
  //Json Parsing Model
  Rxn<MovieDetails> moveDetails = Rxn<MovieDetails>();

  @override
  void onInit() {
    repository = Repository();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

//Fetch Data from Api
  fetchMovieDetails(int id) async {
    try {
      moveDetails.value = await repository!.getMovieDetails(id: id);

      isLoading.value = true;
    } catch (e) {
      print(e);

      Get.back(closeOverlays: true);
    }
  }
}
