import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynomial_form/firebase_options.dart';
import 'package:polynomial_form/repository/firebase_repository.dart';
import 'package:polynomial_form/state/save_details_cubit.dart';
import 'package:polynomial_form/widgets/simple_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SaveDetailsCubit(firebaseRepository: FirebaseRepository()),
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize:
                  WidgetStatePropertyAll<Size>(Size(double.infinity, 40)),
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.green),
              foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
            ),
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("A polynomial login form"),
            elevation: 0,
            centerTitle: true,
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SimpleForm(),
          ),
        ),
      ),
    );
  }
}
