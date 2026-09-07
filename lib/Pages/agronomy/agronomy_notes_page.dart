import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'agronomy_note_detail_page.dart';

class AgronomyNotesPage extends StatefulWidget {
  const AgronomyNotesPage({super.key});

  @override
  State<AgronomyNotesPage> createState() => _AgronomyNotesPageState();
}

class _AgronomyNotesPageState extends State<AgronomyNotesPage> {
  List<Map<String, dynamic>> notes = [];

  bool isLoading = true;

  String? selectedTag;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/agronomy_notes.json',
      );

      final List<dynamic> data = jsonDecode(response);

      if (!mounted) return;

      setState(() {
        notes = data
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        isLoading = false;
      });
    } catch (error) {
      debugPrint('Error loading agronomy notes: $error');

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  List<String> get tags {
    final uniqueTags = notes
        .map(
          (note) => note["tag"] as String,
        )
        .toSet()
        .toList();

    uniqueTags.sort();

    return uniqueTags;
  }

  List<Map<String, dynamic>> get filteredNotes {
    if (selectedTag == null) {
      return notes;
    }

    return notes
        .where(
          (note) => note["tag"] == selectedTag,
        )
        .toList();
  }

  void _toggleTag(String tag) {
    setState(() {
      if (selectedTag == tag) {
        selectedTag = null;
      } else {
        selectedTag = tag;
      }
    });
  }

  Widget _buildFilterChip(String label) {
    final bool isSelected = selectedTag == label;

    return GestureDetector(
      onTap: () => _toggleTag(label),
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 180,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 238, 140, 255)
              : const Color.fromARGB(
                  255,
                  242,
                  242,
                  247,
                ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 255, 137, 249)
                : Colors.black12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard(
    BuildContext context,
    Map<String, dynamic> note,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AgronomyNoteDetailPage(
              title: note["title"] as String,
              images: List<String>.from(
                note["images"] as List,
              ),
              content: note["content"] as String,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 215, 125, 251),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Image.asset(
                note["coverImage"] as String,
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      note["title"] as String,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      note["tag"] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      note["subtitle"] as String,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.2,
                        color: Colors.white70,
                      ),
                    ),

                    const Spacer(),

                    const Row(
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Read note",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Agronomy Notes",
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final visibleNotes = filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Agronomy Notes",
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // FILTER CHIPS
          SizedBox(
            height: 42,
            child: ListView.separated(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              scrollDirection:
                  Axis.horizontal,
              itemCount: tags.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
              itemBuilder:
                  (context, index) {
                return _buildFilterChip(
                  tags[index],
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // NOTES
          Expanded(
            child: visibleNotes.isEmpty
                ? const Center(
                    child: Text(
                      "No notes in this section.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  )
                : GridView.builder(
                    padding:
                        const EdgeInsets.all(12),
                    itemCount:
                        visibleNotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemBuilder:
                        (context, index) {
                      final note =
                          visibleNotes[index];

                      return _buildNoteCard(
                        context,
                        note,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}