window.addEventListener('DOMContentLoaded', () => {
  const container = document.getElementById('replica-container');
  if (!container) return;

  container.innerHTML = renderReplicaCard(providerReplica);
});



interface ContainerStatus {
  name: string;
  status: string;
}

interface Replica {
  id: string;
  containers: ContainerStatus[];
  isSyncing: boolean;
}

const providerReplica: Replica = {
  id: 'provider',
  containers: [
  ],
  isSyncing: true,
};

const replicas: Replica[] = [providerReplica];


function getStatusClass(status: string) {
  switch (status.toLowerCase()) {
    case 'running': return 'text-success';
    case 'stopped': return 'text-secondary';
    case 'error': return 'text-danger';
    default: return 'text-muted';
  }
}

function renderReplicaCard(replica: Replica): string {
  const borderClass = replica.isSyncing ? 'border-success' : 'border-danger';
  const collapseId = `collapse-${replica.id}`;

  const containerItems = replica.containers.map(c => `
    <li class="list-group-item bg-transparent d-flex justify-content-between">
      <span>${c.name}</span>
      <span class="${getStatusClass(c.status)}">${c.status}</span>
    </li>
  `).join('');

  return `
    <div class="col-md-6 mb-3">
      <div class="card p-0 shadow-sm border ${borderClass} border-3">
        <!-- Clickable header toggles collapse -->
        <div class="card-header bg-light d-flex justify-content-between align-items-center" 
             style="cursor:pointer;" 
             data-bs-toggle="collapse" 
             data-bs-target="#${collapseId}" 
             aria-expanded="false" 
             aria-controls="${collapseId}">
          <h6 class="mb-0">${replica.id}</h6>
          <span class="badge rounded-pill ${replica.isSyncing ? 'bg-success' : 'bg-danger'}">
            ${replica.isSyncing ? 'Syncing' : 'Not Syncing'}
          </span>
        </div>
        <!-- Collapsible body -->
        <div id="${collapseId}" class="collapse">
          <ul class="list-group list-group-flush small mb-2">
            ${containerItems}
          </ul>
          <div class="d-flex gap-2 p-3">
            <button class="btn btn-outline-danger btn-sm flex-fill" onclick="disconnectReplica('${replica.id}')">Disconnect</button>
            <button class="btn btn-danger btn-sm flex-fill" onclick="killReplica('${replica.id}')">Kill</button>
          </div>
        </div>
      </div>
    </div>
  `;
}



document.getElementById('deploy-form')?.addEventListener('submit', e => {

    e.preventDefault();
    console.log("Adding a replica");
  // Create a new replica — in real app, collect values from the form
  const newReplica: Replica = {
    id: `replica-${replicas.length + 1}`,
    containers: [
      { name: 'App', status: 'Running' },
      { name: 'Database', status: 'Running' },
      { name: 'Prometheus', status: 'Running' },
      { name: 'Grafana', status: 'Running' },
    ],
    isSyncing: true,
  };

  // Add it to the replicas array
  replicas.push(newReplica);

  // Re-render all replicas to update UI
  renderAllReplicas();
});


function renderAllReplicas() {
  const container = document.getElementById('replica-container');
  if (!container) return;

  container.innerHTML = replicas.map(renderReplicaCard).join('');
}


window.addEventListener('DOMContentLoaded', () => {
  renderAllReplicas();
});