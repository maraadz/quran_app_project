import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranapp_project/controller/fetchController.dart';
import 'package:quranapp_project/model/quran.dart';
import 'package:quranapp_project/shared/shared.dart';

class SurahDetail extends StatelessWidget {
  const SurahDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)!.settings.arguments as Map;
    FetchController fetch = FetchController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MainColor,
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          "Surah ${data['nama_surah']}",
          style: GoogleFonts.changa(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
      body: ListView(
        children: [
          //Bismillah Tile
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 10),
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "بِسْــــــــــــــــــمِ اللهِ الرَّحْمَنِ الرَّحِيْمِ",
                style: GoogleFonts.changa(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Isi
          FutureBuilder(
            future: fetch.fetchData(data['noSurah']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                List<Result>? data = snapshot.data!.result;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data!.length,
                    itemBuilder: (context, index) => AyatTile(
                          ayat: data[index].arabicText!,
                          terjemah: data[index].translation!,
                        ));
              }
            },
          ),
        ],
      ),
    );
  }
}

class AyatTile extends StatelessWidget {
  final String ayat;
  final String terjemah;
  const AyatTile({
    super.key,
    required this.ayat,
    required this.terjemah,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8, bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: MainColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ayat,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              terjemah,
              textAlign: TextAlign.left,
              style: GoogleFonts.lilitaOne(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
