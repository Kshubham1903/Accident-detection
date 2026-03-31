import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../models/hospital.dart'; // No longer needed for static data

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> hospitals = [];

  final List<Map<String, dynamic>> hospitalsData = const [
    {
      "name": "Patil Criticare Hospital",
      "area": "Shirala Naka",
      "lat": 17.049478815715467,
      "lng": 74.25969314674929,
      "rating": 4.5,
      "phone": "+912342567890"
    },
    {
      "name": "Laxmi Narayan Superspeciality Hospital & Critical Care Center",
      "area": "",
      "lat": 17.050121186326948,
      "lng": 74.24983072762149,
      "rating": 4.2,
      "phone": "+912342567891"
    },
    {
      "name": "Chaitanya Multi Speciality Hospital",
      "area": "Shripad Nagar",
      "lat": 17.048830434171563,
      "lng": 74.25289827870037,
      "rating": 4.0,
      "phone": "+912342567892"
    },
    {
      "name": "Sushrut Fracture And Multi Speciality Surgical Hospital",
      "area": "Taklainagar",
      "lat": 17.067416501519652,
      "lng": 74.27418725789795,
      "rating": 4.3,
      "phone": "+912342567893"
    },
    {
      "name": "Aadhar Hospital",
      "area": "Shirala Naka",
      "lat": 17.04079692898944,
      "lng": 74.26159212585806,
      "rating": 4.1,
      "phone": "+912342567894"
    },
    {
      "name": "Koyana Superspeciality Hospital",
      "area": "Peth Road",
      "lat": 17.050874799820665,
      "lng": 74.24967307983064,
      "rating": 4.4,
      "phone": "+912342567895"
    },
    {
      "name": "Islampur Multispeciality Hospital & ICU Center",
      "area": "Shirala Naka",
      "lat": 17.046837060849107,
      "lng": 74.2589872927769,
      "rating": 4.6,
      "phone": "+912342567896"
    }
  ];

  Future<void> openMap(double lat, double lng) async {
    final Uri url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
    );
    if (!await launchUrl(url)) {
      throw 'Could not open map';
    }
  }

  Future<void> makeCall(String phone) async {
    final Uri url = Uri.parse("tel:$phone");
    if (!await launchUrl(url)) {
      throw 'Could not make call';
    }
  }

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        hospitals = List<Map<String, dynamic>>.from(hospitalsData);
        isLoading = false;
      });
    });
  }

  // ...existing code...
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hospitals')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hospitals.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('No hospitals found nearby', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          Future.delayed(const Duration(seconds: 1), () {
                            setState(() {
                              hospitals = List<Map<String, dynamic>>.from(hospitalsData);
                              isLoading = false;
                            });
                          });
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: hospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = hospitals[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 8)
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text("Multi Speciality",
                                      style: TextStyle(color: Colors.purple, fontSize: 12)),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.orange, size: 16),
                                    const SizedBox(width: 2),
                                    Text(hospital["rating"].toString()),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hospital["name"] ?? "",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              (hospital["area"] != null && hospital["area"].toString().isNotEmpty)
                                  ? hospital["area"]
                                  : "-",
                              style: const TextStyle(color: Colors.blue),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => openMap(hospital["lat"], hospital["lng"]),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Colors.deepPurple, Colors.blue],
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.navigation, color: Colors.white),
                                          SizedBox(width: 6),
                                          Text("Navigate Now", style: TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () => makeCall(hospital["phone"]),
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(Icons.call),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
