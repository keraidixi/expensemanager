import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/auth_cubit.dart';
import '../login_screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String email = '';
  String phone = '';
  String address = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final authCubit = context.read<AuthCubit>();

    email = await authCubit.getUserEmail() ?? '';
    phone = await authCubit.getPhone() ?? '';
    address = await authCubit.getAddress() ?? '';

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.email),
              title: Text(email),
            ),

            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(phone),
            ),

            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(address),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () async {
                await context.read<AuthCubit>().logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}