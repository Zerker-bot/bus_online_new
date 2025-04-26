import 'package:bus_online/services/auth_service.dart';
import 'package:flutter/material.dart';

class PersonalPage extends StatelessWidget {
  PersonalPage({super.key});

  final AuthService user = AuthService();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: MediaQuery.of(context).size.height * 0.25 - 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  border: Border.all(width: 3, color: Colors.grey[500]!),
                ),
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/handsome-bearded-guy-posing-against-white-wall_273609-20597.jpg',
                  ),
                ),
              ),
              Text(
                user.getName(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                user.getRole() == "driver" ? "Tài xế" : "Khách hàng",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]!),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        user.logoutWithSupabase();
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Đăng xuất'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
