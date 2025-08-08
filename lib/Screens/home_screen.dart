import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:notepad_app/Provider/note_provider.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Notes",
            style: GoogleFonts.cinzel(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff2F5AAF),
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
