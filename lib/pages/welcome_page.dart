import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir_pam/cubit/app_cubits.dart';
import '../widgets/app_large_text.dart';
import '../widgets/app_text.dart';
import '../misc/colors.dart';
import '../widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome-one.jpg",
    "welcome-two.jpg",
    "welcome-three.jpg",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index){
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
                image: AssetImage(
                  "../img/"+images[index]
                ),
                fit: BoxFit.cover
              )
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 150, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(text: "Rachel Trips", color: Color(0xFF3B3486),),
                      AppText(text: "Mountain", size: 30),
                      SizedBox(height: 20,),
                      Container(
                        width: 250,
                        child: AppText(
                          text: "Mountain hikes give you an incredible sense of freedom along with endurance test",
                          color: Colors.black54,
                          size: 14,
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AppCubits>(context).getData();
                        },
                        child: Container(
                            width: 200,
                            child: Row(children: [ ResponsiveButton(width: 120,)])),
                      )
                    ],
                  ),
                  Column(
                    children: List.generate(3, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom:
                        2),
                        width: 8,
                        height: index==indexDots? 25:8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.5)
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
        );
      }),
    );
  }
}
