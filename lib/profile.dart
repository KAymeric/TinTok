import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatelessWidget{
  Profile({super.key});
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context){
    if (supabase.auth.currentUser == null) {
      Navigator.pushNamed(context, '/login');
    }
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;

      switch (event) {
        case AuthChangeEvent.signedOut:
          Navigator.pushNamed(context, '/login');
        default:
          return;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Title(color: Colors.blue, child:
         Text("Profile de ${supabase.auth.currentUser?.email}")),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await supabase.auth.signOut();
          },
          child: const Text('Logout'),
        ),
      )
    );
  }
}