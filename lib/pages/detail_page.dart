import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir_pam/cubit/app_cubit_states.dart';
import 'package:tugas_akhir_pam/cubit/app_cubits.dart';
import 'package:tugas_akhir_pam/misc/colors.dart';
import 'package:tugas_akhir_pam/widgets/app_buttons.dart';
import 'package:tugas_akhir_pam/widgets/app_large_text.dart';
import 'package:tugas_akhir_pam/widgets/app_text.dart';
import 'package:tugas_akhir_pam/widgets/responsive_button.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List _listdata =[];
  var uri = "http://192.168.43.252/mount-app/destinasi.php";

  Future _getData() async {
    try {
      final response = await http.get(
          Uri.parse(uri));
          if (response.statusCode == 200) {
            print(response.body);
            final data = jsonDecode(response.body);
            setState(() {
              _listdata=data;
            });
          }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getData();
    // print(_listdata);
    super.initState();
  }


  int gottenStars = 4;
  int selectedIndex = -1;

  // var data;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 350,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // image: AssetImage("../img/gunung-merapi.jpg"),
                        image: NetworkImage("http://mark.bslmeiyu.com/uploads/"+detail.places.img),
                        fit: BoxFit.cover
                    ),

                  ),
                ),
              ),
              Positioned(
                  left: 20,
                  top: 20,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<AppCubits>(context).goHome();
                        },
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                      ),
                    ],
                  )),
              Positioned(
                  top: 330,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppLargeText(text: detail.places.name, color: Colors.black.withOpacity(0.8)),
                            AppLargeText(text: "\$"+detail.places.price.toString(), color: AppColors.mainColor,),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: AppColors.mainColor,),
                            SizedBox(width: 5,),
                            AppText(text: detail.places.location, color: AppColors.textColor1,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Wrap(
                              children: List.generate(5, (index) {
                                return Icon(Icons.star, color: index<detail.places.stars? AppColors.starColor:AppColors.textColor2,);
                              }),
                            ),
                            SizedBox(width: 10,),
                            AppText(text: "("+detail.places.stars.toString()+".0)", color: AppColors.textColor2,)
                          ],
                        ),
                        SizedBox(height: 25,),
                        AppLargeText(text: "People", color: Colors.black.withOpacity(0.8), size: 20,),
                        SizedBox(height: 5,),
                        AppText(text: "Number of people in your group", color: AppColors.mainTextColor,),
                        SizedBox(height: 10,),
                        Wrap(
                          children: List.generate(5, (index) {
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  selectedIndex=index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: AppButtons(
                                  size: 50,
                                  color: selectedIndex==index?Colors.white:Colors.black,
                                  backgroundColor: selectedIndex==index?Colors.black:AppColors.buttonBackground,
                                  borderColor: selectedIndex==index?Colors.black:AppColors.buttonBackground,
                                  text: (index+1).toString(),
                                ),
                              ),
                            );

                          }),
                        ),
                        SizedBox(height: 10,),
                        AppLargeText(text: "Description", color: Colors.black.withOpacity(0.8), size: 20,),
                        SizedBox(height: 5,),
                        AppText(text: detail.places.description, color: AppColors.mainTextColor,),

                      ],
                    ),
                  )
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      AppButtons(
                        size: 60,
                        color: AppColors.textColor1,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.textColor1,
                        isIcon : true,
                        icon: Icons.favorite_border,
                      ),
                      SizedBox(width: 20,),
                      ResponsiveButton(
                        isResponsive: true,
                      )
                    ],
                  ))

            ],
          ),
        ),
      );
    });
  }
}
