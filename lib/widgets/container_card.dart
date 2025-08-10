import 'package:flutter/material.dart';
import '../models/container_model.dart';

class ContainerCard extends StatelessWidget {
  final ContainerInfo container;
  
  const ContainerCard({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ExpansionTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: container.status == 'running' ? Colors.green : Colors.red,
          ),
        ),
        title: Text(container.name),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.settings_ethernet, size: 16),
                    const SizedBox(width: 8),
                    Text('Port: ${container.port}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}