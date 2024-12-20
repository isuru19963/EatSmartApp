import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mvvm_app/utils/routes/routes.dart';
import 'package:mvvm_app/utils/routes/routes_names.dart';
import 'package:mvvm_app/viewModel/auth_viewmodel.dart';
import 'package:mvvm_app/viewModel/home_view_model.dart';
import 'package:mvvm_app/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },

        child: MaterialApp(
          title: 'EatSmart',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.actorTextTheme(), // Apply Roboto globally
          ),
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: Routes.generateRoutes,
        ),
      ),
    );
  }
}
