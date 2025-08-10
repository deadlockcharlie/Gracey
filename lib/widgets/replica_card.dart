import 'package:flutter/material.dart';
import '../models/replica_model.dart';
import 'container_card.dart';

class ReplicaCard extends StatelessWidget {
  final Replica replica;
  
  const ReplicaCard({super.key, required this.replica});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 3,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.widgets, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    replica.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: replica.containers.length,
                itemBuilder: (context, index) {
                  return ContainerCard(container: replica.containers[index]);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.green),
                    onPressed: () {},
                    tooltip: 'Start all containers',
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop, color: Colors.red),
                    onPressed: () {},
                    tooltip: 'Stop all containers',
                  ),
                  IconButton(
                    icon: const Icon(Icons.restart_alt, color: Colors.blue),
                    onPressed: () {},
                    tooltip: 'Restart replica',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}