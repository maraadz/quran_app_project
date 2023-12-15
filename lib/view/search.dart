import 'package:flutter/material.dart';
import 'package:quranapp_project/controller/fetchController.dart';
import 'package:quranapp_project/model/quran.dart';
import 'package:quranapp_project/view/home.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Result>? searchData = [];
  TextEditingController searchController = TextEditingController();
  FetchController fetch = FetchController();
  bool isSearching = false;

  Future<void> fetchData(int query) async {
    setState(() {
      isSearching = true;
    });

    final SurahModel datasearch = await fetch.fetchData(query);
    if (datasearch.result!.isNotEmpty) {
      setState(() {
        searchData = datasearch.result;
        isSearching = false;
      });
    } else {
      setState(() {
        isSearching = false;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: searchController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cari Berdasarkan Nomor Surah',
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  int query = int.parse(searchController.text);
                  if (query != 0) {
                    fetchData(query);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          isSearching
              ? CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                    itemCount: searchData!.isEmpty ? searchData!.length : 1,
                    itemBuilder: (context, index) {
                      return SurahTile(
                          namaSurah: "",
                          noSurah: int.parse(searchController.text));
                    },
                  ),
                )
        ],
      ),
    );
  }
}
