import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String userName = "User";
    const String userEmail = 'user@gmail.com';
    const String avatar = 'assets/default-avatar.png';

    return Scaffold(
        appBar: AppBar(title: const Text('Профиль')),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                CircleAvatar(radius: 60, backgroundImage: AssetImage(avatar)),
                const SizedBox(height: 24),
                Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  userEmail,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // todo
                  },
                  child: const Text('Редактировать профиль'),
                ),
              ],
            )));
  }
}
