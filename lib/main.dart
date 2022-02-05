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
  var user = UserModel();
  var passwordCache = '';
  var passwordCacheConfirm = '';
  bool obscureTextPassword = false;

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
                onSaved: (text) => user = user.copyWith(name: text),
                validator: (text) => text == null || text.isEmpty
                    ? 'This field can\'t be empty.'
                    : null,
              ),
              const SizedBox(height: 15),
              CustomTextField(
                  label: "E-mail",
                  icon: Icons.mail,
                  onSaved: (text) => user = user.copyWith(email: text),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'This field can\'t be empty.';
                    }
                    if (!validator.isEmail(text)) {
                      return 'Value must be email type.';
                    }
                  }),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Password",
                icon: Icons.lock,
                obscureText: obscureTextPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                onSaved: (text) => user = user.copyWith(password: text),
                onChanged: (text) => passwordCache = text,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty.';
                  }
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                label: "Confirm password",
                icon: Icons.lock,
                obscureText: obscureTextPassword,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureTextPassword = !obscureTextPassword;
                    });
                  },
                  icon: Icon(obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                onSaved: (text) => user = user.copyWith(password: text),
                onChanged: (text) => passwordCacheConfirm = text,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'This field can\'t be empty.';
                  }
                  if (passwordCacheConfirm != passwordCache) {
                    return 'Your password and confirmation password don\'t match.';
                  }
                },
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
                      print('''FLUTTERANDO FORM\n
                        Name:  ${user.name}
                        Email: ${user.email} 
                        Password: ${user.password} 
                      ''');
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
  final bool obscureText;
  final Widget? suffix;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final void Function(String text)? onChanged;

  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: icon == null ? null : Icon(icon),
        suffixIcon: suffix,
      ),
    );
  }
}

@immutable
class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({
    this.name = '',
    this.email = '',
    this.password = '',
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
