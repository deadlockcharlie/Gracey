// src/website/renderer.tsx
import React from 'react';
import { createRoot } from 'react-dom/client';
import App from './components/App';
import './index.css';

console.log('Renderer process started'); // This should appear in dev tools

const container = document.getElementById('root');
if (!container) throw new Error('Failed to find root element');

const root = createRoot(container);
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);