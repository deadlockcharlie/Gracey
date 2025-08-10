import 'package:flutter/material.dart';
import '../models/replica_model.dart';
import '../models/container_model.dart';
import '../globals.dart';

class ReplicaFormDialog extends StatefulWidget {
  final int appPort;
  final int dbPort;
  final int prometheusPort;
  final int grafanaPort;
  final Function(Replica) onSubmit;

  const ReplicaFormDialog({
    super.key,
    required this.appPort,
    required this.dbPort,
    required this.prometheusPort,
    required this.grafanaPort,
    required this.onSubmit,
  });

  @override
  State<ReplicaFormDialog> createState() => _ReplicaFormDialogState();
}

class _ReplicaFormDialogState extends State<ReplicaFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String _replicaName = '';
  bool _synchronize = false;
  String _database = "Neo4j";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Replica',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Replica Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a replica name';
                    }
                    return null;
                  },
                  onSaved: (value) => _replicaName = value!,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Application Container',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Database',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.network_check),
                  ),
                  value: _database,
                  items: ['Neo4j', 'MemGraph']
                      .map((network) => DropdownMenuItem(
                            value: network,
                            child: Text(network),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() => _database = value!),
                ),
                CheckboxListTile(
                  title: const Text('Replicate?'),
                  value: _synchronize,
                  onChanged: (value) => setState(() => _synchronize = value!),
                  secondary: const Icon(Icons.sync),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: const Text('CANCEL'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      child: const Text('ADD REPLICA'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          widget.onSubmit(Replica(
                            name: _replicaName,
                            containers: [
                              ContainerInfo(
                                'GRACE',
                                'stopped',
                                widget.appPort,
                                _synchronize,
                                "${_replicaName}_Net",
                              ),
                              ContainerInfo(
                                _database,
                                'stopped',
                                widget.dbPort,
                                _synchronize,
                                "${_replicaName}_Net",
                              ),
                              ContainerInfo(
                                'Prometheus',
                                'stopped',
                                widget.prometheusPort,
                                _synchronize,
                                "${_replicaName}_Net",
                              ),
                              ContainerInfo(
                                'Grafana',
                                'stopped',
                                widget.grafanaPort,
                                _synchronize,
                                "${_replicaName}_Net",
                              ),
                            ],
                          ));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}