import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentation/home/bloc/car_events.dart';
import 'package:rentapp/presentation/onpording/pages/onpording.dart';
import 'package:rentapp/presentation/splash/pages/splash.dart';
import 'package:rentapp/servecs_locator.dart';
import 'package:rentapp/presentation/home/bloc/car_bloc.dart';
import 'package:rentapp/domain/usecase/cars_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print('✅ Firebase initialized successfully');
  } catch (e, stackTrace) {
    print("🔥 Firebase initialization error: $e");
    print("Stack trace: $stackTrace");
  }

  try {
    setupServiceLocator();
    print('✅ Service Locator initialized successfully');
  } catch (e, stackTrace) {
    print("🔥 Service Locator initialization error: $e");
    print("Stack trace: $stackTrace");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CarBloc(getCars: sl<CarsUsecase>())..add(LoadCars()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
