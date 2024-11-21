import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynomial_form/domain/polynomial_calculator.dart';
import 'package:polynomial_form/state/save_details_cubit.dart';

class SimpleForm extends StatefulWidget {
  const SimpleForm({super.key});

  @override
  State<SimpleForm> createState() => _SimpleFormState();
}

class _SimpleFormState extends State<SimpleForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _polynomialController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _polynomialController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final derivativeAnswer = derivative(_polynomialController.text);

      context.read<SaveDetailsCubit>().saveCurrentDetails(
            _loginController.text,
            _passwordController.text,
            _polynomialController.text,
            derivativeAnswer,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveDetailsCubit, SaveDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          loading: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: LinearProgressIndicator()),
          ),
          loaded: (derivative) {
            _loginController.text = "";
            _passwordController.text = "";
            _polynomialController.text = "";
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("The Derivative is $derivative")),
            );
          },
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("An Error occurred saving the data")),
            );
          },
          orElse: () {},
        );
      },
      child: BlocBuilder<SaveDetailsCubit, SaveDetailsState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "User Name",
                  ),
                  controller: _loginController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: false,
                  decoration: const InputDecoration(labelText: "Password"),
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter a password';
                    }
                    if (value.length < 8) {
                      return 'password must be atleast 8 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _polynomialController,
                  decoration: const InputDecoration(
                    labelText: "Polynomial",
                    hintText: "enter a valid polynomial e.g 3x^2 + 4x -2",
                  ),
                  validator: (value) {
                    final polynomialRegex = RegExp(
                        r'^[-+]?(\d+)?(x(\^\d+)?)?([+-](\d+)?(x(\^\d+)?)?)*$');
                    if (value!.isEmpty) {
                      return "Enter a polynomial";
                    }
                    if (!polynomialRegex.hasMatch(value)) {
                      return "Input a valid polynomial";
                    }
                    return null;
                  },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text("Submit"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
