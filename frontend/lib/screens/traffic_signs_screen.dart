import 'package:flutter/material.dart';
import '../models/traffic_sign.dart';
import '../services/api_service.dart';
import '../language.dart';

class TrafficSignsScreen extends StatefulWidget {
  const TrafficSignsScreen({super.key});

  @override
  State<TrafficSignsScreen> createState() => _TrafficSignsScreenState();
}

class _TrafficSignsScreenState extends State<TrafficSignsScreen> {
  List<TrafficSign> signs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadSigns();
  }

  Future<void> loadSigns() async {
    try {
      signs = await ApiService.getTrafficSigns();
    } catch (e) {
      debugPrint("Error loading signs: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<bool>(
          valueListenable: isUrdu,
          builder: (_, value, __) => Text(value ? "ٹریفک کے اشارے" : "Traffic Signs"),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isUrdu,
              builder: (_, value, __) => Text(value ? "EN" : "اردو",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            onPressed: () => isUrdu.value = !isUrdu.value,
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : signs.isEmpty
              ? const Center(child: Text("No traffic signs found"))
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: signs.length,
                  itemBuilder: (context, index) {
                    final sign = signs[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.network(
                                sign.image,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 50, color: Colors.red),
                              ),
                            ),
                            const SizedBox(height: 8),
                            ValueListenableBuilder<bool>(
                              valueListenable: isUrdu,
                              builder: (_, value, __) => Text(
                                value ? sign.nameUr : sign.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 6),
                            ValueListenableBuilder<bool>(
                              valueListenable: isUrdu,
                              builder: (_, value, __) => Text(
                                value ? sign.descriptionUr : sign.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}