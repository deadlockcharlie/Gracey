import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // For getting documents directory
import 'globals.dart';
import './utils/docker_utils.dart';
import 'screens/home_screen.dart';
import 'screens/docker_error_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDockerRunning = await DockerUtils.isDockerRunning();
  print(isDockerRunning);
  runApp(GraceManagerApp(isDockerRunning: isDockerRunning));
}

class GraceManagerApp extends StatelessWidget {
  final bool isDockerRunning;
  
  const GraceManagerApp({super.key, required this.isDockerRunning});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docker Stack Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isDockerRunning? const HomeScreen(): const DockerErrorScreen(),
    );
  }
}

// class AddReplicaDialog extends StatefulWidget {
//   final int appPort;
//   final int dbPort;
//   final int prometheusPort;
//   final int grafanaPort;
//   final Function(Replica) onSubmit;

//   const AddReplicaDialog({
//     Key? key,
//     required this.appPort,
//     required this.dbPort,
//     required this.prometheusPort,
//     required this.grafanaPort,
//     required this.onSubmit,
//   }) : super(key: key);
//   @override
//   _AddReplicaDialogState createState() => _AddReplicaDialogState();
// }

// class _AddReplicaDialogState extends State<AddReplicaDialog> {
//   final _formKey = GlobalKey<FormState>();

//   String _replicaName = '';
//   bool _synchronize = false;
//   String _database = "Neo4j";

//   late int _appPort;
//   late int _dbPort;
//   late int _prometheusPort;
//   late int _grafanaPort;

//   @override
//   void initState() {
//     super.initState();
//     _appPort = widget.appPort;
//     _dbPort = widget.dbPort;
//     _prometheusPort = widget.prometheusPort;
//     _grafanaPort = widget.grafanaPort;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       insetPadding: EdgeInsets.symmetric(),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Add New Replica',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),

//                 // Replica Name
//                 TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Replica Name',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.badge),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a replica name';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) => _replicaName = value!,
//                 ),
//                 SizedBox(height: 16),

//                 // App Configuration
//                 Text(
//                   'Application Container',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),

//                 DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Select Database',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.network_check),
//                   ),
//                   value: _database,
//                   items: ['Neo4j', 'MemGraph']
//                       .map(
//                         (network) => DropdownMenuItem(
//                           value: network,
//                           child: Text(network),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => _database = value!),
//                 ),

//                 CheckboxListTile(
//                   title: Text('Replicate?'),
//                   value: _synchronize,
//                   onChanged: (value) => setState(() => _synchronize = value!),
//                   secondary: Icon(Icons.sync),
//                   controlAffinity: ListTileControlAffinity.leading,
//                 ),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       child: Text('CANCEL'),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     SizedBox(width: 8),
//                     ElevatedButton(
//                       child: Text('ADD REPLICA'),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();

//                           final newReplica = Replica(
//                             name: _replicaName,
//                             containers: [
//                               ContainerInfo(
//                                 'GRACE',
//                                 'stopped',
//                                 _appPort,
//                                 _synchronize,
//                                 "${_replicaName}_Net",
//                               ),
//                               ContainerInfo(
//                                 _database,
//                                 'stopped',
//                                 _dbPort,
//                                 _synchronize,
//                                 "${_replicaName}_Net",
//                               ),
//                               ContainerInfo(
//                                 'Prometheus',
//                                 'stopped',
//                                 _prometheusPort,
//                                 _synchronize,
//                                 "${_replicaName}_Net",
//                               ),
//                               ContainerInfo(
//                                 'Grafana',
//                                 'stopped',
//                                 _grafanaPort,
//                                 _synchronize,
//                                 "${_replicaName}_Net",
//                               ),
//                             ],
//                           );

//                           widget.onSubmit(newReplica);
//                           Navigator.pop(context);
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StackManagementPage extends StatefulWidget {
//   @override
//   _StackManagementPageState createState() => _StackManagementPageState();
// }

// class _StackManagementPageState extends State<StackManagementPage> {
//   List<Replica> _replicas = [];
//   bool _isLoading = true;



//   @override
//   void initState() {
//     super.initState();
//     _loadDemoData();
//   }

//   void _loadDemoData() async {
//     // Simulate loading
//     await Future.delayed(Duration(seconds: 1));

//     setState(() {
//       _replicas = [
//         Replica(
//           name: 'Provider',
//           containers: [
//             ContainerInfo(
//               'WS Provider',
//               'stopped',
//               12314,
//               true,
//               "Provider_Net",
//             ),
//           ],
//         ),
//       ];
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Grace Deployment Manager',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         // actions: [
//         //   // IconButton(icon: Icon(Icons.refresh), onPressed: _loadDemoData),
//         //   ElevatedButton.icon(
//         //       icon: Icon(Icons.edit),
//         //       label: Text('Create Replica'),
//         //       onPressed: _showAddReplicaDialog,
//         //     ),
//         // ],
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _buildReplicaLayout(),
//     );
//   }

//   void _showAddReplicaDialog() {
//     final nextReplicaNumber =
//         _replicas.length -
//         1; // There is always the provider in the list so the first port i can use is 1
//     final nextAppPort = Ports.getAppPort(nextReplicaNumber);
//     final nextDbPort = Ports.getDatabasePort(nextReplicaNumber);
//     final nextPrometheusPort = Ports.getPrometheusPort(nextReplicaNumber);
//     final nextGrafanaPort = Ports.getGrafanaPort(nextReplicaNumber);

//     showDialog(
//       context: context,
//       builder: (context) => AddReplicaDialog(
//         appPort: nextAppPort,
//         dbPort: nextDbPort,
//         prometheusPort: nextPrometheusPort,
//         grafanaPort: nextGrafanaPort,
//         onSubmit: (newReplica) {
//           setState(() {
//             _replicas.add(newReplica);
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Replica ${newReplica.name} added successfully'),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildReplicaLayout() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           // Stack-level controls
//           _buildStackControls(),
//           SizedBox(height: 10),
//           // Replica list
//           Expanded(
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: _replicas
//                   .map((replica) => _buildReplicaColumn(replica))
//                   .toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStackControls() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             ElevatedButton.icon(
//               icon: Icon(Icons.edit),
//               label: Text('Create Replica'),
//               onPressed: _showAddReplicaDialog,
//             ),

//             // ElevatedButton.icon(
//             //   icon: Icon(Icons.play_arrow),
//             //   label: Text('Start All'),
//             //   onPressed: () {},
//             // ),
//             // ElevatedButton.icon(
//             //   icon: Icon(Icons.stop),
//             //   label: Text('Stop All'),
//             //   onPressed: () {},
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReplicaColumn(Replica replica) {
//     return Container(
//       width: 300,
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       child: Card(
//         elevation: 3,
//         child: Column(
//           children: [
//             // Replica header
//             Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.widgets, color: Colors.blue),
//                   SizedBox(width: 8),
//                   Text(
//                     replica.name,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   Spacer(),
//                 ],
//               ),
//             ),
//             // Container list
//             Expanded(
//               child: ListView.builder(
//                 itemCount: replica.containers.length,
//                 itemBuilder: (context, index) {
//                   return _buildContainerCard(replica.containers[index]);
//                 },
//               ),
//             ),
//             // Replica footer
//             Container(
//               padding: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.play_arrow, color: Colors.green),
//                     onPressed: () {},
//                     tooltip: 'Start all containers',
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.stop, color: Colors.red),
//                     onPressed: () {},
//                     tooltip: 'Stop all containers',
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.restart_alt, color: Colors.blue),
//                     onPressed: () {},
//                     tooltip: 'Restart replica',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContainerCard(ContainerInfo container) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: ExpansionTile(
//         leading: Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: container.status == 'running' ? Colors.green : Colors.red,
//           ),
//         ),
//         title: Text(container.name),
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.settings_ethernet, size: 16),
//                     SizedBox(width: 8),
//                     Text('Port: ${container.port}'),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// String _generateComposeContent(Replica replica) {
//   final buffer = StringBuffer();

//   buffer.writeln('services:');

//   // App service
//   buffer.writeln('  ${replica.containers[0].name}:');
//   buffer.writeln('    image: ${replica.containers[0].image}');
//   buffer.writeln('    ports:');
//   buffer.writeln('      - "${replica.containers[0].port}:${replica.containers[0].port}"');
//   buffer.writeln('    networks:');
//   buffer.writeln('      - ${replica.containers[0].networks[0]}');

//   // Database service
//   buffer.writeln('  ${replica.containers[1].name}:');
//   buffer.writeln('    image: ${replica.containers[1].image}');
//   buffer.writeln('    ports:');
//   buffer.writeln('      - "${replica.containers[1].port}:${replica.containers[1].port}"');
//   buffer.writeln('    networks:');
//   buffer.writeln('      - ${replica.containers[1].networks[0]}');

//   // Monitoring services (if included)
//   if (replica.containers.length > 2) {
//     // Prometheus
//     buffer.writeln('  ${replica.containers[2].name}:');
//     buffer.writeln('    image: ${replica.containers[2].image}');
//     buffer.writeln('    ports:');
//     buffer.writeln('      - "${replica.containers[2].port}:${replica.containers[2].port}"');
//     buffer.writeln('    networks:');
//     buffer.writeln('      - ${replica.containers[2].networks[0]}');

//     // Grafana
//     buffer.writeln('  ${replica.containers[3].name}:');
//     buffer.writeln('    image: ${replica.containers[3].image}');
//     buffer.writeln('    ports:');
//     buffer.writeln('      - "${replica.containers[3].port}:${replica.containers[3].port}"');
//     buffer.writeln('    networks:');
//     buffer.writeln('      - ${replica.containers[3].networks[0]}');
//   }

//   buffer.writeln('networks:');
//   buffer.writeln('  ${replica.containers[0].networks[0]}:');
//   buffer.writeln('    driver: bridge');

//   return buffer.toString();
