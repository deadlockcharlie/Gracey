import { useState } from 'react';
import Editor from 'react-simple-code-editor';
import { highlight, languages } from 'prismjs/components/prism-core';
import 'prismjs/components/prism-json';  // load json syntax
import 'prismjs/themes/prism-tomorrow.css'; // dark theme


interface Card {
  id: number;
  title: string;
  description: string;
}

function App() {
  const [cards, setCards] = useState<Card[]>([]);
  const [jsonInput, setJsonInput] = useState<string>('{\n "n": 2,\n "database":"memgraph", \n "base_http_port": 7474,\n "base_bolt_port": 7687,\n "base_app_port": 3000,\n "base_prometheus_port": 9090, \n "base_grafana_port": 5000,\n "password": "verysecretpassword",\n "provider_port": 1234, \n "provider": true \n}');
  const [error, setError] = useState<string | null>(null);

  const addCardsFromJSON = () => {
    try {
      const parsed = JSON.parse(jsonInput);
      setError(null);

      const replicas = typeof parsed.n === 'number' && parsed.n > 0
        ? parsed.n
        : 1;

      const newCards = Array.from({ length: replicas }, (_, i) => ({
        id: Date.now() + i,
        title: `Grace Replica ${cards.length + i + 1}`,
        description: 'A running Docker container',
      }));

      setCards([...cards, ...newCards]);
    } catch {
      setError('Invalid JSON');
    }
  };

  return (
    <div style={{ fontFamily: 'Arial, sans-serif', background: '#f8f9fa', minHeight: '80vh' }}>
      {/* Header */}
      <header
        style={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          background: '#ffffff',
          padding: '10px 20px',
          boxShadow: '0 2px 5px rgba(0,0,0,0.1)',
          position: 'sticky',
          top: 0,
        }}
      >
        <div style={{ display: 'flex', alignItems: 'center' }}>
          <img
            src="./static/images/logo.png"
            alt="Logo"
            style={{ height: '100px', marginRight: '10px' }}
          />
          <h1 style={{ fontSize: '1.5rem', color: '#333', margin: 0 }}>Docker Demo Dashboard</h1>
        </div>
        <div>
          <button
          onClick={addCardsFromJSON}
          style={{
            padding: '8px 16px',
            background: '#007bff',
            color: 'white',
            border: 'none',
            borderRadius: '5px',
            cursor: 'pointer',
            margin:'10px'
          }}
        >
          Deploy
        </button>

        <button
          style={{
            padding: '8px 16px',
            background: '#007bff',
            color: 'white',
            border: 'none',
            borderRadius: '5px',
            cursor: 'pointer',
          }}
        >
          Tear Down
        </button>

        </div>
        

      </header>

      {/* Body split */}
      <main style={{ display: 'flex', height: 'calc(90vh - 70px)' }}>
        {/* Left half: Cards */}
        <div style={{ flex: 1, padding: '20px', overflowY: 'auto' }}>
          {cards.length === 0 ? (
            <p style={{ color: '#777' }}>No containers yet. Specify a deployment.</p>
          ) : (
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))',
                gap: '15px',
              }}
            >
              {cards.map((card) => (
                <div
                  key={card.id}
                  style={{
                    background: 'white',
                    padding: '15px',
                    borderRadius: '8px',
                    boxShadow: '0 2px 5px rgba(0,0,0,0.1)',
                  }}
                >
                  <h3 style={{ marginTop: 0 }}>{card.title}</h3>
                  <p>{card.description}</p>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Right half: JSON editor */}
          <div style={{ flex: 1, borderLeft: '1px solid #ddd', padding: '20px'}}>
          <Editor
            value={jsonInput}
            onValueChange={setJsonInput}
            highlight={code => highlight(code, languages.json, 'json')}
            padding={10}
            style={{
              fontFamily: '"Fira code", monospace',
              fontSize: 14,
              minHeight: '70%',
              outline: 'none',
              borderRadius: '4px',
              backgroundColor: '#1e1e1e',
              color: '#ddd',
              whiteSpace: 'pre-wrap',
              overflowWrap: 'break-word',
            }}
          />
          {error && (
            <p style={{ color: '#ff6c6b', marginTop: '5px' }}>{error}</p>
          )}
        </div>
      </main>
    </div>
  );
}

export default App;
