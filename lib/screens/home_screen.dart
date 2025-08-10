import 'package:flutter/material.dart';
import '../models/replica_model.dart';
import '../widgets/replica_card.dart';
import 'replica_form_dialog.dart';
import '../globals.dart';
import '../models/container_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Replica> _replicas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDemoData();
  }

  void _loadDemoData() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _replicas = [
        Replica(
          name: 'Provider',
          containers: [
            ContainerInfo(
              'WS Provider',
              'stopped',
              12314,
              true,
              "Provider_Net",
            ),
          ],
        ),
      ];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grace Deployment Manager',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildReplicaLayout(),
    );
  }

  Widget _buildReplicaLayout() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildStackControls(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _replicas
                  .map((replica) => ReplicaCard(replica: replica))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text('Create Replica'),
              onPressed: _showAddReplicaDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddReplicaDialog() {
    final nextReplicaNumber = _replicas.length - 1;
    showDialog(
      context: context,
      builder: (context) => ReplicaFormDialog(
        appPort: Ports.getAppPort(nextReplicaNumber),
        dbPort: Ports.getDatabasePort(nextReplicaNumber),
        prometheusPort: Ports.getPrometheusPort(nextReplicaNumber),
        grafanaPort: Ports.getGrafanaPort(nextReplicaNumber),
        onSubmit: (newReplica) {
          setState(() {
            _replicas.add(newReplica);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Replica ${newReplica.name} added successfully'),
            ),
          );
        },
      ),
    );
  }
}