import 'package:flutter/material.dart';

void main() => runApp(AirPollutantsInfo());

class AirPollutantsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Air Pollutants',
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5,0,5,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/gif/airpollutantsinfo.gif',
                fit: BoxFit.fill,),
              Text('Understanding Air Pollutants',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,0,8,0),
                child: Text(
                  'Air quality is affected by various pollutants that can impact human health and the environment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                child: PollutantsList(), // <-- must be inside Expanded to allow scrolling
              ),
            ],
          ),
          
        ),
      ),

    );
  }
}

class PollutantsList extends StatelessWidget {
  final List<Pollutant> pollutants = [
    Pollutant(
      "Ozone (O₃)",
      Colors.orange,
      Icons.air,
      "Ground-level ozone forms when pollutants from cars, power plants, and other sources react chemically with sunlight. It can trigger respiratory problems and worsen conditions like asthma and bronchitis.\nSOURCES\nVehicle exhaust, industrial emissions, chemical solvents, gasoline vapors\n\nHEALTH EFFECTS\nBreathing difficulties, throat irritation, congestion, chest pain, worsening of respiratory infections\n\nENVIRONMENTAL IMPACT\nDamages vegetation and ecosystems, reduces crop yields",
    ),
    Pollutant(
      "Particulate Matter (PM2.5/PM10)",
      Colors.pink.shade100,
      Icons.blur_on,
      "Tiny particles or droplets in the air that are 2.5 microns or less in width (PM2.5) or 10 microns or less (PM10). They can penetrate deep into the lungs and even enter the bloodstream.\nSOURCES\nVehicle emissions, power plants, wood burning, construction, dust, wildfires\n\nHEALTH EFFECTS\nRespiratory and cardiovascular issues, irregular heartbeat, aggravated asthma, decreased lung function\n\nENVIRONMENTAL IMPACT\nReduced visibility (haze), acidification of water bodies, soil nutrient depletion",
    ),
    Pollutant(
      "Carbon Monoxide (CO)",
      Colors.purple.shade100,
      Icons.directions_car,
      "A colorless, odorless gas that forms when carbon in fuel doesn't burn completely. It reduces oxygen delivery to the body's organs and can be fatal at high concentrations.\nSOURCES\nVehicle exhaust, fuel combustion, industrial processes, household appliances\n\nHEALTH EFFECTS\nReduced oxygen delivery to organs, headaches, dizziness, confusion, unconsciousness at high levels\n\nENVIRONMENTAL IMPACT\nContributes to ground-level ozone formation",
    ),
    Pollutant(
      "Nitrogen Dioxide (NO₂)",
      Colors.red.shade200,
      Icons.warning,
      "A reddish-brown gas with a sharp odor that forms when fossil fuels are burned at high temperatures. It contributes to the formation of ground-level ozone and fine particle pollution.\nSOURCES\nVehicle emissions, power plants, industrial processes\n\nHEALTH EFFECTS\nRespiratory inflammation, worsened asthma symptoms, increased susceptibility to respiratory infections\n\nENVIRONMENTAL IMPACT\nContributes to acid rain, nutrient pollution in coastal waters",
    ),
    Pollutant(
      "Sulfur Dioxide (SO₂)",
      Colors.brown.shade200,
      Icons.cloud,
      "A colorless gas with a sharp odor that forms when sulfur-containing fuels are burned. It can harm the respiratory system and contribute to acid rain.\nSOURCES\nFossil fuel combustion, industrial processes, volcanic eruptions\n\nHEALTH EFFECTS\nBreathing difficulties, respiratory irritation, worsening of asthma and heart disease\n\nENVIRONMENTAL IMPACT\nContributes to acid rain, damages trees and plants, acidifies water bodies",
    ),
    Pollutant(
      "Ammonia (NH₃)",
      Colors.green.shade200,
      Icons.eco,
      "A colorless gas with a pungent odor. It is a common byproduct of agricultural activities and can contribute to particulate matter formation.\nSOURCES\nAgricultural activities, livestock waste, fertilizer application, industrial processes\n\nHEALTH EFFECTS\nEye, nose, and throat irritation, respiratory issues at high concentrations\n\nENVIRONMENTAL IMPACT\nContributes to nitrogen pollution in ecosystems, forms secondary particulate matter",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: pollutants.map((pollutant) => _buildTile(pollutant)).toList(),
    );
  }

  Widget _buildTile(Pollutant pollutant) {
    return Card(
      color: pollutant.color,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ExpansionTile(
        leading: Icon(pollutant.icon, color: Colors.black54),
        title: Text(
          pollutant.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              pollutant.description,
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

class Pollutant {
  final String name;
  final Color color;
  final IconData icon;
  final String description;

  Pollutant(this.name, this.color, this.icon, this.description);
}
