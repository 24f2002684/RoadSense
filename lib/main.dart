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
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        primaryColor: Color(0xFF00E5FF),
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: HomeScreen(),
    );

  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0E21), Color(0xFF112240)],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.auto_awesome, size: 90, color: Color(0xFF00E5FF)),
                SizedBox(height: 20),
                Text(
                  "RoadSense",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "AI‑Powered Road Intelligence",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00E5FF),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "START DRIVE MODE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
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

    Color accentColor = Color(0xFF00E5FF);

    return Scaffold(
      appBar: AppBar(title: Text("AI Detection"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 CENTERED RESULT CARD
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 380, // controls card width
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF112240),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: accentColor.withOpacity(0.35),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 55,
                        color: accentColor,
                      ),
                      SizedBox(height: 12),
                      Text(
                        detectedType,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Severity: $severity",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Road Health Score",
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "$healthScore / 100",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 35),

            /// 🔹 VIEW MAP BUTTON
            futuristicButton(
              icon: Icons.map,
              text: "VIEW MAP",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => MapScreen()),
                );
              },
            ),

            SizedBox(height: 12),

            /// 🔹 AI INSIGHT BUTTON
            futuristicButton(
              icon: Icons.smart_toy,
              text: "AI INSIGHT",
              onTap: () {
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


Widget futuristicButton({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ElevatedButton.icon(
    icon: Icon(icon),
    label: Text(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF00E5FF),
      foregroundColor: Colors.black,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    onPressed: onTap,
  );
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
      appBar: AppBar(title: Text("AI Insight")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF112240),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF00E5FF)),
                  SizedBox(width: 8),
                  Text(
                    "Gemini Insight",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Repeated pothole detections indicate severe road degradation. "
                "Temporary repairs are likely to fail under traffic and rainfall. "
                "Permanent resurfacing is recommended for long‑term safety.",
                style: TextStyle(fontSize: 15, color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


