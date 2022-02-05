import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart' as validator;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Forms'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextField(
                label: "Name",
                icon: Icons.person,
                validator: (text) => text == null || text.isEmpty
                    ? 'This field can\'t be empty.'
                    : null,
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                label: "E-mail",
                icon: Icons.mail,
                validator: (text) {
                  return '';
                  /*if (text == null || text.isEmpty) {
                    //return 'This field can\'t be empty.';
                  }*/
                },
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                label: "Password",
                icon: Icons.lock,
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                label: "Confirm password",
                icon: Icons.lock,
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                    }
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  onPressed: () {
                    formkey.currentState?.reset();
                  },
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;

  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (text) {
        if (text == null || text.isEmpty) {
          return 'This field can\'t be empty.';
        }
        return null;
      },
      onSaved: (text) {},
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon == null ? null : Icon(icon),
      ),
    );
  }
}


git config --global user.email "lelisvaldo@outlook.com"
git config --global user.name "lelisvaldo"