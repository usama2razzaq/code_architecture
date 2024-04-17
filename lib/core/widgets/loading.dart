import 'package:assignment/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required Transition transition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SpinKitWanderingCubes(
          color: AppColors.teal,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Center(
            child: Text(
              'Loading',
              style: TextStyle(color: AppColors.teal),
            ),
          ),
        )
      ],
    );
  }
}
