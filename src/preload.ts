import { contextBridge, ipcRenderer } from 'electron';

contextBridge.exposeInMainWorld('api', {
  deploy: (configPath: string) => ipcRenderer.invoke('deploy', configPath),
});
