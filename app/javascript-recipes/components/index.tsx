import React from "react";
import { ReactDom, createRoot } from "react-dom/client";
import App from "./App";
import { store } from './app/store';
import { Provider } from 'react-redux';


document.addEventListener("turbo:load", () => {
  const rootElement = document.getElementById('root');
  const root = ReactDom.createRoot(rootElement as HTMLElement);
    document.body.appendChild(document.createElement("div"))
  );
  root.render(
    <React.StrictMode>
      <Provider store={store}>
        <App />
      </Provider>
    </React.StrictMode>
  );
});