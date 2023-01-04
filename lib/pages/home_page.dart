import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir_pam/cubit/app_cubit_states.dart';
import 'package:tugas_akhir_pam/cubit/app_cubits.dart';
import 'package:tugas_akhir_pam/misc/colors.dart';
import 'package:tugas_akhir_pam/widgets/app_large_text.dart';
import 'package:tugas_akhir_pam/widgets/app_text.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images = {
    "balloning.png" : "Balloning",
    "hiking.png" : "Hiking",
    "kayaking.png" : "Kayaking",
    "snorkling.png" : "Snorkling",
  };
  //
  // List gunung = [
  //   "gunung-bromo.jpg",
  //   "gunung-rinjani.jpg",
  //   "gunung-merapi.jpg",
  //   "gunung-merapi1.jpg",
  // ];

  // var data;

  List _listdata =[];
  var uri = "http://localhost/mount-app-mongo/destinasi.php";

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

  // Future<String> getData() async {
  //   var url = Uri.parse("http://localhost/mount-app/read.php");
  //   http.Response response = await http.get(
  //     url,
  //   );
  //   setState(() {
  //     data = json.decode(response.body);
  //   });
  //   return "success";
  // }

  @override
  void initState() {
    _getData();
    // print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates> (
        builder: (context, state){
          if(state is LoadedState) {
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Menu text
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.black54,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //Discover text
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Discover"),
                ),
                SizedBox(
                  height: 10,
                ),
                //Tabbar
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator:
                      CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                      tabs: [
                        Tab(
                          text: "Places",
                        ),
                        Tab(
                          text: "Inspiration",
                        ),
                        Tab(
                          text: "Emotions",
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 280,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: _listdata.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                                onTap: (){
                                  BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                                },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15, top: 10),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                    // image: NetworkImage(data[index]['gambar']),
                                    image: AssetImage(_listdata[index]['gambar']),
                                    //"../img/gunung/"
                                    // image: NetworkImage("http://mark.bslmeiyu.com/uploads/"+info[index].img),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      ),
                      Text("There"),
                      Text("Bye"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: "Explore more",
                        size: 22,
                      ),
                      AppText(text: "See all", color: AppColors.textColor1),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 120,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Container(
                                //margin: const EdgeInsets.only(right: 50),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage("../img/"+images.keys.elementAt(index)),
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(height: 20),
                              Container(
                                child: AppText(
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          } else {
            return Container();
          }
        },
      )
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
