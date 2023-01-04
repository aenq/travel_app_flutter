import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugas_akhir_pam/cubit/app_cubit_states.dart';
import 'package:tugas_akhir_pam/cubit/app_cubits.dart';
import 'package:tugas_akhir_pam/pages/detail_page.dart';
import 'package:tugas_akhir_pam/pages/home_page.dart';
import 'package:tugas_akhir_pam/pages/register-page.dart';


import '../pages/navpages/main_page.dart';
import '../pages/welcome_page.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  State<AppCubitLogic> createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates> (
        builder: (context, state) {
          if(state is DetailState) {
            return DetailPage();
          }if(state is WelcomeState) {
            return WelcomePage();
          }if(state is LoadedState) {
            return Register();
          }  if(state is LoadingState) {
            return Center(child: CircularProgressIndicator(),);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

