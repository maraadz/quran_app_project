import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapp_project/controller/firebase_AuthController.dart';
import 'package:quranapp_project/shared/shared.dart';
import 'package:quranapp_project/view/about.dart';
import 'package:quranapp_project/view/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuthController _auth = FirebaseAuthController();
  int currentIndexPage = 0;

  final List _pages = [
    MainView(surah: [
      SurahTile(namaSurah: "An-Nas", noSurah: 114),
      SurahTile(namaSurah: "Al-Falaq", noSurah: 113),
      SurahTile(namaSurah: "Al-Ikhlas", noSurah: 112),
      SurahTile(namaSurah: "Al-Lahab", noSurah: 111),
      SurahTile(namaSurah: "An-Nashr", noSurah: 110),
      SurahTile(namaSurah: "An-Kafirun", noSurah: 109),
      SurahTile(namaSurah: "An-Kautsar", noSurah: 108),
      SurahTile(namaSurah: "An-Ma'un", noSurah: 107),
      SurahTile(namaSurah: "Al-Quraisy", noSurah: 106),
      SurahTile(namaSurah: "Al-Al-Fiil", noSurah: 105),
      SurahTile(namaSurah: "Al-Humazah", noSurah: 104),
      SurahTile(namaSurah: "Al-\'Ashr", noSurah: 103),
      SurahTile(namaSurah: "Al-Takaatsur", noSurah: 102),
      SurahTile(namaSurah: "Al-Qaari\'ah", noSurah: 101),
      SurahTile(namaSurah: "Al-\'Adiyat", noSurah: 100),
      SurahTile(namaSurah: "Al-Zalzalah", noSurah: 99),
      SurahTile(namaSurah: "Al-Bayyinah", noSurah: 98),
      SurahTile(namaSurah: "Al-Qadr", noSurah: 97),
      SurahTile(namaSurah: "Al-Alaq\'", noSurah: 96),
      SurahTile(namaSurah: "At-Tin", noSurah: 95),
      SurahTile(namaSurah: "Al-Insyirah", noSurah: 94),
      SurahTile(namaSurah: "Ad-Dhuha", noSurah: 93),
    ]),
    SearchPage(),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: SecondColor,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: MainColor,
          currentIndex: currentIndexPage,
          fixedColor: Colors.white,
          unselectedItemColor: SecondColor,
          showUnselectedLabels: false,
          onTap: (newIndex) {
            setState(() {
              currentIndexPage = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Search",
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: "About",
              icon: Icon(Icons.person),
            ),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MainColor,
          toolbarHeight: 100,
          title: RichText(
            text: TextSpan(
                style: GoogleFonts.changa(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 1,
                ),
                children: [
                  TextSpan(
                    text: "Selamat Datang\n",
                  ),
                  TextSpan(
                    text: "Yuk Ngaji Dulu",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ]),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _auth.signOut();
                });
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              icon: Icon(
                Icons.logout_rounded,
                size: 30,
              ),
            )
          ],
        ),
        body: _pages[currentIndexPage]);
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required List surah,
  }) : _surah = surah;

  final List _surah;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _surah.length,
      itemBuilder: (context, index) => _surah[index],
    );
  }
}

class SurahTile extends StatelessWidget {
  final String namaSurah;
  final int noSurah;
  const SurahTile({
    super.key,
    required this.namaSurah,
    required this.noSurah,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/surah', arguments: {
          'noSurah': noSurah,
          'nama_surah': namaSurah,
        }),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                //Surah Number
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12),
                  child: Image.asset(
                    "assets/koran.png",
                    fit: BoxFit.cover,
                  ),
                  decoration: BoxDecoration(
                    color: MainColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                // Surah Name and Juz
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Surah Ke-$noSurah",
                      style: GoogleFonts.lilitaOne(
                        color: MainColor,
                        fontSize: 27,
                      ),
                    ),
                    Text(
                      namaSurah,
                      style: GoogleFonts.lilitaOne(
                        color: MainColor,
                        fontSize: 27,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
