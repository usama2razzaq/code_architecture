import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:assignment/networks/data_model/moivie_response.dart';
import 'package:assignment/networks/API/repository.dart';

class MovieController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool loadPage = false.obs;
  RxBool isNextPage = false.obs, allowNextPage = true.obs;
  RxInt page = 1.obs, perPage = 20.obs;
  Repository? repository;
  MovieList? movieList;
  RxList<Result>? savedMovieList = <Result>[].obs;
  final currentDate = DateTime.now();
  DateTime? endDate;
  DateTime? startDate;
  final dateFormat = DateFormat('yyyy-MM-dd');

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    repository = Repository();
    endDate = currentDate;
    startDate =
        DateTime(currentDate.year - 1, currentDate.month, currentDate.day);

    fetchMovieList();
    // Listen to scroll events
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // At the bottom of the list, load more data
        fetchMovieList();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // Fetch Data from Api
  fetchMovieList() async {
    try {
      isLoading(true);
      movieList = await repository!.getMovie(
        page: page.value,
        pageSize: perPage.value,
        startDate: dateFormat.format(startDate!).toString(),
        endDate: dateFormat.format(endDate!).toString(),
      );

      if (movieList!.results!.isNotEmpty) {
        savedMovieList!.addAll(movieList!.results!);
        page.value++;
      } else {
        // No more data available
        allowNextPage(false);
      }
    } catch (e) {
      print(e);
      Get.back(closeOverlays: true);
    } finally {
      isLoading(false);
    }
  }
}
