import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notepad_app/Provider/multi_select_provider.dart';

import 'package:notepad_app/Provider/note_provider.dart';
import 'package:notepad_app/Provider/theme_provider.dart';
import 'package:notepad_app/Screens/add_note_screen.dart';
import 'package:notepad_app/Widget/note_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).loadNotesSP();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final multiSelectProvider = Provider.of<MultiSelectProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: multiSelectProvider.isSelectionMode
              ? Text(
                  "${multiSelectProvider.selectedIndexes.length} selected",
                  style: GoogleFonts.cinzel(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : Text(
                  "Notes",
                  style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
          centerTitle: true,
          backgroundColor: Color(0xff2F5AAF),
          actions: [
            if (multiSelectProvider.isSelectionMode)
              IconButton(
                icon: Icon(Icons.delete, color: Colors.white),
                onPressed: () {
                  multiSelectProvider.deleteSelected((index) {
                    noteProvider.onNoteDelete(index);
                  });
                },
              ),
            if (!multiSelectProvider.isSelectionMode)
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Switch(
                                value: Provider.of<ThemeProvider>(
                                  context,
                                ).isDark,
                                onChanged: Provider.of<ThemeProvider>(
                                  context,
                                ).toggleTheme,
                              ),
                              Text("Dark Mode"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.more_vert, color: Colors.white),
              ),
          ],
          leading: multiSelectProvider.isSelectionMode
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    multiSelectProvider.clearSelection();
                  },
                )
              : null,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff2F5AAF),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNoteScreen()),
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: Provider.of<NoteProvider>(context).notes.isEmpty
            ? Center(
                child: Text(
                  "No Notes",
                  style: GoogleFonts.cinzel(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        Provider.of<NoteProvider>(
                          context,
                          listen: false,
                        ).updateSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Search Notes",

                        prefixIcon: Icon(Icons.search),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Consumer<NoteProvider>(
                      builder: (context, value, child) {
                        return ListView.builder(
                          itemCount: value.filteredNotes.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: NoteCard(
                                index: index,
                                value: value,
                                note: value.filteredNotes[index],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
