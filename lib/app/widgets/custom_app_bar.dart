import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Gradient Container
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFD8E9A8),
                    Color(0xFF1E5128),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    // Profile image
                    ClipOval(
                      child: Image.network(
                        "https://imgs.search.brave.com/EQwbpjTWOjGzqB5UYYu9inlAzhLlj1S_N7qOUUOxkY0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9zdGF0/aWMudmVjdGVlenku/Y29tL3N5c3RlbS9y/ZXNvdXJjZXMvdGh1/bWJuYWlscy8wNTkv/MzQwLzY4OC9zbWFs/bC9wcm9mZXNzaW9u/YWwtbWFuLXBvc2Vz/LWNvbmZpZGVudGx5/LWluLW1vZGVybi1v/ZmZpY2Utd2l0aC1s/YXJnZS13aW5kb3dz/LWFuZC11cmJhbi12/aWV3LXBob3RvLmpw/Zw",
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 40),
                    // Name and role
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hermant Rangarajan",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Full Stack Developer",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Company Logo or Top Right Icon
            Positioned(
              top: 10,
              right: -20,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
