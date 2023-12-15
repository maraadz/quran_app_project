import 'package:flutter/material.dart';
import 'package:quranapp_project/shared/shared.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          // Photo
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/splashart.png'),
            backgroundColor: MainColor,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          ProfileTile(ikon: Icons.phone_android, title: "ngaji_app:1.0"),
          ProfileTile(ikon: Icons.api_sharp, title: "quranenc.com/api/v1"),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final IconData ikon;
  final String title;
  const ProfileTile({
    super.key,
    required this.ikon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: 280,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
