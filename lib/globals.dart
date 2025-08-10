class Ports {
  static int _baseAppPort = 3000;
  static int _baseDatabasePort = 7474;
  static int _baseProtocolPort = 7687;
  static int _basePrometheusPort = 9090;
  static int _baseGrafanaPort = 5000;

  static int getAppPort(int replicaNumber)=> _baseAppPort + replicaNumber;
  static int getDatabasePort(int replicaNumber) => _baseDatabasePort + replicaNumber;
  static int getProtocolPort(int replicaNumber) => _baseProtocolPort + replicaNumber;
  static int getPrometheusPort(int replicaNumber) => _basePrometheusPort + replicaNumber;
  static int getGrafanaPort(int replicaNumber) => _baseGrafanaPort + replicaNumber;
}
