import 'package:flutter/material.dart';
import 'package:frontend/models/rule.dart';


import '../services/api_service.dart';
import '../language.dart';

class RuleBookScreen extends StatefulWidget {
  const RuleBookScreen({super.key});

  @override
  State<RuleBookScreen> createState() => _RuleBookScreenState();
}

class _RuleBookScreenState extends State<RuleBookScreen> {
  List<Rule> rules = [];
  List<Rule> filteredRules = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadRules();
  }

  /// Load rules from API and ensure content is always List<String>
  void loadRules() async {
    try {
      rules = await ApiService.getRules();

      // Normalize content to List<String> if backend returns a string
      rules = rules.map((rule) {
        // For English content
        if (rule.content is String) {
          rule.content = (rule.content as String)
              .split("\n")
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
        }
        // For Urdu content
        if (rule.contentUr != null && rule.contentUr is String) {
          rule.contentUr = (rule.contentUr as String)
              .split("\n")
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .toList();
        }
        return rule;
      }).toList();

      filteredRules = rules;
    } catch (e) {
      debugPrint("Error loading rules: $e");
    }
    setState(() => isLoading = false);
  }

  void search(String query) {
    setState(() {
      searchQuery = query;

      filteredRules = rules.where((rule) {
        final combinedText = [
          rule.title,
          ...rule.content,
          if (rule.titleUr != null) rule.titleUr!,
          if (rule.contentUr != null) ...rule.contentUr!
        ].join(" ");

        return combinedText.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Rule Book"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isUrdu,
              builder: (_, value, __) => Text(
                value ? "EN" : "اردو",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () => isUrdu.value = !isUrdu.value,
          )
        ],
      ),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search rules...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📚 RULE LIST
          Expanded(
            child: ListView.builder(
              itemCount: filteredRules.length,
              itemBuilder: (context, index) {
                final rule = filteredRules[index];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),

                      // 📌 TITLE
                      title: ValueListenableBuilder<bool>(
                        valueListenable: isUrdu,
                        builder: (_, value, __) => Text(
                          value && rule.titleUr != null
                              ? rule.titleUr!
                              : rule.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),

                      // 📌 CONTENT
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isUrdu,
                          builder: (_, value, __) {
                            // Convert string to list if necessary
                            List<String> contentList = [];
                            if (value && rule.contentUr != null) {
                              contentList = rule.contentUr is String
                                  ? (rule.contentUr as String)
                                      .split("\n")
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList()
                                  : rule.contentUr!;
                            } else {
                              contentList = rule.content is String
                                  ? (rule.content as String)
                                      .split("\n")
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList()
                                  : rule.content;
                            }

                            return Column(
                              children: contentList.map((item) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.check_circle,
                                          color: Colors.green, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        )
                      ],
                    ),
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