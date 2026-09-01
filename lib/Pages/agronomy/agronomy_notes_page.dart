import 'package:flutter/material.dart';
import 'agronomy_note_detail_page.dart';

class AgronomyNotesPage extends StatefulWidget {
  const AgronomyNotesPage({super.key});

  @override
  State<AgronomyNotesPage> createState() => _AgronomyNotesPageState();
}

class _AgronomyNotesPageState extends State<AgronomyNotesPage> {
  static const List<Map<String, dynamic>> notes = [
    {
      "title": "Note 1",
      "subtitle": "Lorem ipsum subtitle 1",
      "tag": "Section 1",
      "coverImage": "assets/images/agronomy/agronomy1.png",
      "images": [
        "assets/images/agronomy/agronomy1.png",
        "assets/images/agronomy/agronomy2.png",
      ],
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n"
          "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
          "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n"
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
          "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. \n\n"
          "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    },
    {
      "title": "Note 2",
      "subtitle": "Lorem ipsum subtitle 2",
      "tag": "Section 1",
      "coverImage": "assets/images/agronomy/agronomy2.png",
      "images": [
        "assets/images/agronomy/agronomy2.png",
        "assets/images/agronomy/agronomy3.png",
      ],
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.\n\n"
          "Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. "
          "Fusce nec tellus sed augue semper porta.",
    },
    {
      "title": "Note 3",
      "subtitle": "Lorem ipsum subtitle 3",
      "tag": "Section 2",
      "coverImage": "assets/images/agronomy/agronomy3.png",
      "images": [
        "assets/images/agronomy/agronomy3.png",
        "assets/images/agronomy/agronomy1.png",
      ],
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\n"
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    },
    {
      "title": "Note 4",
      "subtitle": "Lorem ipsum subtitle 4",
      "tag": "Section 2",
      "coverImage": "assets/images/agronomy/agronomy4.png",
      "images": [
        "assets/images/agronomy/agronomy4.png",
        "assets/images/agronomy/agronomy2.png",
      ],
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sodales ligula in libero.\n\n"
          "Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam.",
    },
    {
      "title": "Note 5",
      "subtitle": "Lorem ipsum subtitle 5",
      "tag": "Section 3",
      "coverImage": "assets/images/agronomy/agronomy5.png",
      "images": [
        "assets/images/agronomy/agronomy5.png",
        "assets/images/agronomy/agronomy3.png",
      ],
      "content":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam nec ante.\n\n"
          "Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis.",
    },
  ];

  String? selectedTag;

  List<String> get tags {
    final uniqueTags = notes.map((note) => note["tag"] as String).toSet().toList();
    uniqueTags.sort();
    return uniqueTags;
  }

  List<Map<String, dynamic>> get filteredNotes {
    if (selectedTag == null) return notes;
    return notes.where((note) => note["tag"] == selectedTag).toList();
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
    final isSelected = selectedTag == label;

    return GestureDetector(
      onTap: () => _toggleTag(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 150, 14, 218)
              : const Color.fromARGB(255, 242, 242, 247),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 150, 14, 218)
                : Colors.black12,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, Map<String, dynamic> note) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AgronomyNoteDetailPage(
              title: note["title"] as String,
              images: List<String>.from(note["images"] as List),
              content: note["content"] as String,
            ),
          ),
        );
      },
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 150, 14, 218),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            SizedBox(
              width: 120,
              height: double.infinity,
              child: Image.asset(
                note["coverImage"] as String,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note["title"] as String,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note["tag"] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(210, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      note["subtitle"] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(137, 255, 255, 255),
                      ),
                    ),
                    const Spacer(),
                    const Row(
                      children: [
                        Icon(
                          Icons.menu_book_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Read note",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
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
    final visibleNotes = filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Agronomy Notes"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 42,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              scrollDirection: Axis.horizontal,
              itemCount: tags.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return _buildFilterChip(tags[index]);
              },
            ),
          ),
          const SizedBox(height: 12),
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
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: visibleNotes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final note = visibleNotes[index];
                      return _buildNoteCard(context, note);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}