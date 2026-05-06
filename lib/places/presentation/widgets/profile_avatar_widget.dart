import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.grey[300],
      backgroundImage: const NetworkImage(
          'https://randomuser.me/api/portraits/men/1.jpg'
          //'https://firebasestorage.googleapis.com/v0/b/maf-app-dev.appspot.com/o/avatars%2Fdefault.png?alt=media&token=c79b0e56-38b9-4df4-9d1d-6e42eb78a580'
          ),
    );
  }
}
