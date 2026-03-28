import 'dart:html' as html;
import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';

class RuleBookPdfScreen extends StatefulWidget {
  const RuleBookPdfScreen({super.key});

  @override
  State<RuleBookPdfScreen> createState() => _RuleBookPdfScreenState();
}

class _RuleBookPdfScreenState extends State<RuleBookPdfScreen> {
  final String baseUrl = "http://192.168.100.153:8000/rulebook/view";

  int currentPage = 1;
  List<int> bookmarks = [];
  bool isDarkMode = false;

  late String viewerId;

  @override
  void initState() {
    super.initState();
    viewerId = "pdf-viewer-${DateTime.now().millisecondsSinceEpoch}";
    _registerIframe();
  }

  void _registerIframe() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      viewerId,
      (int viewId) {
        final iframe = html.IFrameElement()
          ..src = "$baseUrl#page=$currentPage"
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%';

        return iframe;
      },
    );
  }

  void reloadPdf() {
    setState(() {
      viewerId = "pdf-viewer-${DateTime.now().millisecondsSinceEpoch}";
      _registerIframe();
    });
  }

  void goToPage(int page) {
    currentPage = page;
    reloadPdf();
  }

  void addBookmark() {
    if (!bookmarks.contains(currentPage)) {
      setState(() => bookmarks.add(currentPage));
    }
  }

  void openBookmark(int page) {
    goToPage(page);
  }

  void openSearch() {
    // triggers browser find (CTRL+F)
    html.window.alert("Press CTRL + F to search inside PDF");
  }

  void downloadPdf() {
    html.window.open(
      "http://192.168.100.153:8000/rulebook/download",
      "_blank",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Punjab Rule Book"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: openSearch,
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            onPressed: addBookmark,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: downloadPdf,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: reloadPdf,
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() => isDarkMode = !isDarkMode);
            },
          ),
        ],
      ),

      body: Column(
        children: [
          /// 🔹 TOP CONTROL BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            child: Row(
              children: [
                /// Page input
                SizedBox(
                  width: 80,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Page",
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (value) {
                      final page = int.tryParse(value);
                      if (page != null) goToPage(page);
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Text(
                  "Current: $currentPage",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),

                const Spacer(),

                /// Progress (fake but useful)
                Text(
                  "Progress: ${(currentPage * 2)}%",
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          /// 📄 PDF VIEWER
          Expanded(
            child: Stack(
              children: [
                HtmlElementView(viewType: viewerId),

                /// 🌙 Dark overlay (fake dark mode)
                if (isDarkMode)
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
              ],
            ),
          ),

          /// ⭐ BOOKMARK BAR
          if (bookmarks.isNotEmpty)
            Container(
              height: 60,
              color: isDarkMode ? Colors.grey[900] : Colors.white,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final page = bookmarks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () => openBookmark(page),
                      child: Text("Page $page"),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}