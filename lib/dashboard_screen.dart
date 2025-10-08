import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<int> scores = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadScores();
  }

  Future<void> loadScores() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email == null) return;

    final snap = await FirebaseFirestore.instance
        .collection('results')
        .where('email', isEqualTo: email)
        .orderBy('timestamp', descending: false)
        .get();

    scores = snap.docs
        .map((d) => (d.data()['score'] as num?)?.toInt() ?? 0)
        .toList();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : scores.isEmpty
              ? const Center(
                  child: Text(
                    'No quiz attempts yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          'Q${value.toInt() + 1}',
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 28,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          value.toInt().toString(),
                                          style: const TextStyle(fontSize: 10),
                                        );
                                      },
                                    ),
                                  ),
                                  rightTitles:
                                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  topTitles:
                                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(show: true),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: true,
                                    color: Colors.blueAccent,
                                    barWidth: 3,
                                    dotData: FlDotData(show: true),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.blueAccent.withOpacity(0.2),
                                    ),
                                    spots: [
                                      for (int i = 0; i < scores.length; i++)
                                        FlSpot(i.toDouble(), scores[i].toDouble()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Scores Summary',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: scores
                            .map(
                              (s) => Chip(
                                label: Text(
                                  s.toString(),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.blue.shade50,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
    );
  }
}
