import 'package:ecommerce/manager/user_details/user_details_bloc.dart';
import 'package:ecommerce/presentation/loading_screen.dart';
import 'package:ecommerce/presentation/screen_manager/screen_bloc/screen_bloc.dart';
import 'package:ecommerce/utilis/app_router.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  // await FirebaseAppCheck.instance.activate(
  //   webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key')
  // );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => ScreenBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'E-Commerce App',
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

