import 'package:flutter/material.dart';

class FertilizerReferenceDetailPage extends StatefulWidget {
  final String title;
  final List<String> images;
  final List<Map<String, dynamic>> sections;

  const FertilizerReferenceDetailPage({
    super.key,
    required this.title,
    required this.images,
    required this.sections,
  });

  @override
  State<FertilizerReferenceDetailPage> createState() =>
      _FertilizerReferenceDetailPageState();
}

class _FertilizerReferenceDetailPageState
    extends State<FertilizerReferenceDetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.images.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 10 : 8,
          height: _currentPage == index ? 10 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color.fromARGB(255, 255, 55, 172)
                : Colors.grey.shade400,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildSection(Map<String, dynamic> section) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section["heading"] as String,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 255, 55, 172),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            section["text"] as String,
            style: const TextStyle(
              fontSize: 16,
              height: 1.55,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    widget.images[index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: Text("Image not found"),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            _buildDots(),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.sections
                    .map((section) => _buildSection(section))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}