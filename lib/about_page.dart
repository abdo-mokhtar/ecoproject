import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderBox(),
            const SizedBox(height: 20),
            _buildSectionTitle('Our Mission', Icons.public),
            _buildTextBox(
                'Our mission is to empower users with accurate, real-time data on air and water quality to promote healthier living, safer workplaces, and sustainable communities worldwide.'),
            const SizedBox(height: 20),
            _buildSectionTitle('How EcoSense Works', Icons.bar_chart),
            _buildTextBox(
                'EcoSense collects data using IoT sensors and external sources, analyzes it with machine learning, and provides personalized insights and recommendations through a user-friendly app and website.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Data Collection', Icons.sensors),
            _buildTextBox(
                'IoT sensors gather real-time environmental data including air quality metrics (NO₂, SO₂, CO₂, CO) and water quality indicators.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Analysis', Icons.analytics),
            _buildTextBox(
                'Advanced machine learning algorithms process the data to identify patterns and predict future trends.'),
            const SizedBox(height: 20),
            _buildSectionTitle('Insights', Icons.insights),
            _buildTextBox(
                'Users receive personalized recommendations and alerts through our intuitive interface.'),
            const SizedBox(height: 20),
            _buildSectionTitle('UN Sustainable Development Goals', Icons.eco),
            _buildTextBox(
                'SDG 3: Health and Well-being\nEnsuring healthy lives and promoting well-being for all.\n\nSDG 11: Sustainable Cities\nAdvanced machine learning algorithms process the data to identify patterns and predict future trends.\n\nSDG 13: Climate Action\nUsers receive personalized recommendations and alerts through our intuitive interface.'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.public, color: Colors.white, size: 40),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Transforming Environmental Insights into Action',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade700),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTextBox(String content) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
