import 'package:assignment/config/theme/colors.dart';
import 'package:assignment/core/widgets/loading.dart';
import 'package:assignment/user_interface/controller/movie_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieDetailsPage extends StatelessWidget {
  int? getid;
  MovieDetailsPage({Key? key, required this.getid, e}) : super(key: key);

  final MovieDetailsController movieDetailsCtrl =
      Get.put(MovieDetailsController());

  Widget build(BuildContext context) {
    print(getid);
    movieDetailsCtrl.fetchMovieDetails(getid!);
    return Obx(() => Scaffold(
        body: !movieDetailsCtrl.isLoading.value
            ? const LoadingWidget(transition: Transition.leftToRight)
            : CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.teal,
                    pinned: true,
                    title: Text(
                      movieDetailsCtrl.moveDetails.value!.title!,
                      maxLines: 4,
                    ),
                    expandedHeight: 260.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(children: [
                        CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.backdropPath}"),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 120,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                  AppColors.darkGrey,
                                  Colors.transparent
                                ])),
                          ),
                        ),
                      ]),
                      collapseMode: CollapseMode.parallax,
                    ),
                  ),
                  SliverFillRemaining(
                    child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 0, left: 5, bottom: 5),
                                      child: Text(
                                        'Genres',
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: movieDetailsCtrl
                                                .moveDetails
                                                .value!
                                                .genres!
                                                .length,
                                            itemBuilder: (context, index) {
                                              final genre = movieDetailsCtrl
                                                  .moveDetails
                                                  .value!
                                                  .genres?[index];
                                              return Container(
                                                margin: const EdgeInsets.all(2),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.teal),
                                                child: Center(
                                                    child: Text(
                                                  genre?.name ?? '',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                              );
                                            })),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      movieDetailsCtrl
                                          .moveDetails.value!.overview!,
                                      style: const TextStyle(
                                          color: AppColors.black),
                                      textAlign: TextAlign.justify,
                                      maxLines: 9,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Text(
                                    'Productuon',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (var i = 0;
                                          i <
                                              movieDetailsCtrl
                                                  .moveDetails
                                                  .value!
                                                  .productionCompanies!
                                                  .length;
                                          i++)
                                        Card(
                                          child: movieDetailsCtrl
                                                      .moveDetails
                                                      .value!
                                                      .productionCompanies![i]
                                                      .logoPath ==
                                                  null
                                              ? Container()
                                              : Image.network(
                                                  "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.productionCompanies![0].logoPath}",
                                                  fit: BoxFit.scaleDown,
                                                  scale: 5,
                                                ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.only(top: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(
                                          //     horizontal: 16.0, vertical: 24.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              movieDetailsCtrl.moveDetails
                                                          .value!.posterPath ==
                                                      null
                                                  ? Container()
                                                  : Card(
                                                      child: Image.network(
                                                        "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.posterPath}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              movieDetailsCtrl.moveDetails
                                                          .value!.posterPath ==
                                                      null
                                                  ? Container()
                                                  : Card(
                                                      child: Image.network(
                                                        "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.backdropPath}",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                              movieDetailsCtrl
                                                          .moveDetails
                                                          .value!
                                                          .belongsToCollection ==
                                                      null
                                                  ? Container()
                                                  : movieDetailsCtrl
                                                              .moveDetails
                                                              .value!
                                                              .belongsToCollection!
                                                              .posterPath ==
                                                          null
                                                      ? Container()
                                                      : Card(
                                                          child: Image.network(
                                                            "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.belongsToCollection!.posterPath}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                              movieDetailsCtrl
                                                          .moveDetails
                                                          .value!
                                                          .belongsToCollection ==
                                                      null
                                                  ? Container()
                                                  : movieDetailsCtrl
                                                              .moveDetails
                                                              .value!
                                                              .belongsToCollection!
                                                              .backdropPath ==
                                                          null
                                                      ? Container()
                                                      : Card(
                                                          child: Image.network(
                                                            "https://image.tmdb.org/t/p/w500${movieDetailsCtrl.moveDetails.value!.belongsToCollection!.backdropPath}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                ],
              )));
  }
}
