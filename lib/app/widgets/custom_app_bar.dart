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
                    Color(0xFF00416A),
                    Color(0xFF799F0C),
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
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://i.pinimg.com/736x/60/c0/e5/60c0e5a45dbc723e391a8554602360bb.jpg"))),
                    ),
                    const SizedBox(width: 20),
                    // Name and role
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sreejith",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Flutter Developer",
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
