import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() {
  runApp(RoadSenseApp());
}

class RoadSenseApp extends StatelessWidget {
  const RoadSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RoadSense',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RoadSense"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.verified, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.aod, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              "AI‑Powered Road Safety",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Detecting potholes & unsafe road conditions using AI",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text("Start Drive Mode"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DetectionScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class DetectionScreen extends StatelessWidget {
  const DetectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated ML output
    String detectedType = "Pothole";
    String severity = "High";
    int healthScore = 35;

    Color severityColor = severity == "High" ? Colors.red : Colors.orange;

    return Scaffold(
      appBar: AppBar(title: Text("Detection Result")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.warning, color: severityColor, size: 50),
                    SizedBox(height: 10),
                    Text(
                      detectedType,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Chip(
                      label: Text("Severity: $severity"),
                      // ignore: deprecated_member_use
                      backgroundColor: severityColor.withOpacity(0.2),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Road Health Score",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "$healthScore / 100",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton.icon(
              icon: Icon(Icons.map),
              label: Text("View on Map"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MapScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.smart_toy),
              label: Text("AI Insight"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InsightScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LatLng potholeLocation = LatLng(13.0827, 80.2707); // Chennai

    return Scaffold(
      appBar: AppBar(title: Text("Road Hazard Map")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: potholeLocation,
          zoom: 14,
        ),
        markers: {
          Marker(
            markerId: MarkerId("pothole1"),
            position: potholeLocation,
            infoWindow: InfoWindow(
              title: "Pothole Detected",
              snippet: "High severity road damage",
            ),
          ),
        },
      ),
    );
  }
}

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Insight (Gemini)")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.smart_toy, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "AI Recommendation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Repeated pothole detections indicate severe road degradation. "
                  "Temporary repairs may fail under traffic and rainfall. "
                  "A permanent resurfacing solution is recommended to improve safety.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

