// packages
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// files
import 'package:stravovani_app/api/authentication.dart';
import 'package:stravovani_app/functions.dart';
import 'package:stravovani_app/globals.dart' as globals;
import 'package:stravovani_app/classes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late String username;
  late String password;

  bool showPassword = false;

  void loginSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await login(username: username, password: password);

      if (response.$1 == 200) {
        final json = response.$2;
        // save token to storage
        await saveTokenToStorage(json!["token"]);

        // load user
        if (!mounted) return;
        context.go("/load:type=user", extra: {
          "userId": json["userId"],
          "token": json["token"],
        });
      } else if (response.$1 == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Špatné uživatelské jméno nebo heslo"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Nepodařilo se přihlásit"),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 32,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Přihlášení",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofillHints: const [AutofillHints.username],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      labelText: "Uživatelské jméno",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Zadejte uživatelské jméno";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      username = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofillHints: const [AutofillHints.password],
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Heslo",
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Zadejte heslo";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: loginSubmit,
                    child: const Text(
                      "Přihlásit se",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
