// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import '../css/app.css';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import 'phoenix_html';
import { Socket } from 'phoenix';
import topbar from 'topbar';
import { LiveSocket } from 'phoenix_live_view';

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute('content');
let liveSocket = new LiveSocket('/live', Socket, {
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: '#29d' }, shadowColor: 'rgba(0, 0, 0, .3)' });
window.addEventListener('phx:page-loading-start', (info) => topbar.show());
window.addEventListener('phx:page-loading-stop', (info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

window.onload = () => {
  // add dark link
  const menu = document.querySelector('.app-main-nav');
  const li = document.createElement('li');
  const a = document.createElement('a');
  let theme =
    localStorage.getItem('theme') ||
    (window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light');
  menu.append(li);
  li.append(a);
  a.href = '#';
  a.textContent = theme === 'dark' ? 'Light' : 'Dark';
  a.title = 'Switch dark mode';
  a.onclick = (e) => {
    e.preventDefault();
    theme = theme === 'dark' ? 'light' : 'dark';
    localStorage.setItem('theme', theme);
    const html = document.querySelector('html');
    if (theme === 'dark') {
      html.classList.add('dark');
      a.textContent = 'Light';
    } else {
      html.classList.remove('dark');
      a.textContent = 'Dark';
    }
  };
};
