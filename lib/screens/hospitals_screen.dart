import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
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
      "lng": 74.25969314674929
    },
    {
      "name": "Laxmi Narayan Superspeciality Hospital & Critical Care Center",
      "area": "",
      "lat": 17.050121186326948,
      "lng": 74.24983072762149
    },
    {
      "name": "Chaitanya Multi Speciality Hospital",
      "area": "Shripad Nagar",
      "lat": 17.048830434171563,
      "lng": 74.25289827870037
    },
    {
      "name": "Sushrut Fracture And Multi Speciality Surgical Hospital",
      "area": "Taklainagar",
      "lat": 17.067416501519652,
      "lng": 74.27418725789795
    },
    {
      "name": "Aadhar Hospital",
      "area": "Shirala Naka",
      "lat": 17.04079692898944,
      "lng": 74.26159212585806
    },
    {
      "name": "Koyana Superspeciality Hospital",
      "area": "Peth Road",
      "lat": 17.050874799820665,
      "lng": 74.24967307983064
    },
    {
      "name": "Islampur Multispeciality Hospital & ICU Center",
      "area": "Shirala Naka",
      "lat": 17.046837060849107,
      "lng": 74.2589872927769
    }
  ];

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
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Hospitals Nearby',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.separated(
                          itemCount: hospitals.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final hospital = hospitals[index];
                            return ListTile(
                              leading: const Icon(Icons.local_hospital, color: Color(0xFF5E36F5)),
                              title: Text(hospital["name"] ?? ""),
                              subtitle: Text(hospital["area"] != null && hospital["area"].toString().isNotEmpty ? hospital["area"] : "-"),
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
