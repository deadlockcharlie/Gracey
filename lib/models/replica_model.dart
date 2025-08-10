import 'container_model.dart';
class Replica {
  final String name;
  final List<ContainerInfo> containers;

  Replica({required this.name, required this.containers});
}