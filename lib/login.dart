import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _loginKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;

      switch (event) {
        case AuthChangeEvent.signedIn:
          Navigator.pushNamed(context, '/home');
        default:
          return;
      }
    });

    return Scaffold(
      body: Column(
        children: [Form(
          key: _loginKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async{
                  if (_loginKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('login ...')),
                    );
                    try {
                      await supabase.auth.signInWithPassword(
                        email: email.text,
                        password: password.text,
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                },
                child: const Text('login'),
              ),
            ],
          ),
        ),
        Form(
          key: _signUpKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async{
                  if (_signUpKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('creating account ...')),
                    );
                    try {
                      await supabase.auth.signUp(
                      email: email.text,
                      password: password.text,
                    );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                    await supabase.auth.signUp(
                      email: email.text,
                      password: password.text,
                    ).then((onValue) => supabase.auth.signInWithPassword(
                      email: email.text,
                      password: password.text,
                    ));
                  }
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
        ]
      ),
    );
  }
}