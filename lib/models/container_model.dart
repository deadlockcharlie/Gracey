class ContainerInfo {
  final String name;
  final String status;
  final int port;
  final bool synchronize;
  final String network;

  ContainerInfo(
    this.name,
    this.status,
    this.port,
    this.synchronize,
    this.network,
  );
}