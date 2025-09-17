import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hour_ain/core/constants/app_colors.dart';
import 'package:hour_ain/core/constants/app_images.dart';
import 'package:hour_ain/core/constants/app_typography.dart';
import 'package:hour_ain/features/home/model/Services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.backgroundColor,
              automaticallyImplyLeading: false,
              toolbarHeight: 150,
              floating: true,
              title: Text("Hello Nada",
                  style: AppTypography.title2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image(image: AssetImage(AppImages.applogo)),
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 420,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: Services().myservices.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(                               
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     Image(
                                      height: 60,
                                      image: AssetImage(
                                      Services().assetPaths[index])),
                                    Text(
                                      Services().myservices[index],
                                      textAlign: TextAlign.center,
                                      style: AppTypography.body2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
