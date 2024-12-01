import 'package:flutter/material.dart';

import '../res/widgets/coloors.dart';
import '../res/widgets/round_button.dart';
import '../utils/routes/routes_names.dart';
import '../viewModel/intro_viewmodel.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
    IntroService.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

        body: Container(
          height: double.infinity*1.2,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/Introduction.png"),
                fit: BoxFit.cover),
          ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextButton(
                onPressed: () {

                  Navigator.pushNamed(context, RouteNames.login);

                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(width, height * 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 25,color: Colors.black),

                ),
              ),
            ),
          ],
        ),)
    );
  }
}
