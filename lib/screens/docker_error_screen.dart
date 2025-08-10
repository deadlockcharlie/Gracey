import 'package:flutter/material.dart';
import '../utils/docker_utils.dart';
import '../screens/home_screen.dart';

class DockerErrorScreen extends StatelessWidget {
  const DockerErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Docker Required')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 20),
            const Text(
              'Docker is not running',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Retry'),
              onPressed: () async {
                final isRunning = await DockerUtils.isDockerRunning();
                if (isRunning) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}