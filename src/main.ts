import { app, BrowserWindow, ipcMain } from 'electron';
import path from 'path';
import { spawn } from 'child_process';

function createWindow() {
  const win = new BrowserWindow({
    width: 1920,
    height: 1080,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
    },
  });

  win.loadFile(path.join(__dirname, './static/index.html'));
}

app.whenReady().then(createWindow);

ipcMain.handle('deploy', async (_event, configPath: string) => {
  return new Promise((resolve, reject) => {
    const proc = spawn('python3', ['deploy.py', configPath]);
    let output = '';

    proc.stdout.on('data', (data) => {
      output += data.toString();
    });

    proc.stderr.on('data', (data) => {
      output += data.toString();
    });

    proc.on('close', (code) => {
      if (code === 0) resolve(output);
      else reject(new Error(`Deployment failed: ${output}`));
    });
  });
});
