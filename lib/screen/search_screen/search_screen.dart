import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zameen_zpp/screen/main_screen/main_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? searchQuery = '';
  List<String> categories = ['Land', 'Building', 'Factory'];
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Call a function to delete all search history
              deleteAllSearchHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onSubmitted: (value) {
                saveSearchHistory(value);
                // Navigate to the main screen with the search query
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(searchQuery: value),
                  ),
                );
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Search History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: searchHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchHistory[index]),
                  onLongPress: () {
                    // Show dialog to confirm deletion
                    showDeleteConfirmationDialog(index);
                  },
                  onTap: () {
                    // Navigate to the main screen with the search query from history
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainScreen(searchQuery: searchHistory[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('searchHistory') ?? [];
    });
  }

  void saveSearchHistory(String query) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> updatedHistory = [query, ...searchHistory];
    prefs.setStringList('searchHistory', updatedHistory);
    loadSearchHistory();
  }

  void deleteSearchHistory(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistory.removeAt(index);
    prefs.setStringList('searchHistory', searchHistory);
    loadSearchHistory();
  }

  void deleteAllSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('searchHistory');
    loadSearchHistory();
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Confirmation'),
          content: Text('Are you sure you want to delete this search history?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteSearchHistory(index);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
