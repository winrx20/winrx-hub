const registry = {
  "9router": { category:"service", description:"AI routing gateway and provider fallback service", port:20128, repo:"winrx20/9router" },
  "gum": { category:"cli", description:"Glamorous shell script toolkit", repo:"winrx20/gum" },
  "FckSignups": { category:"web", description:"Open-source browser tools with no signups", port:3002, repo:"winrx20/FckSignups" },
  "SeeStack": { category:"web", description:"Visualize data flow through functions and conditions", port:3001, repo:"winrx20/SeeStack" },
  "mastermind": { category:"web", description:"Mastermind web project", port:3003, repo:"winrx20/mastermind" },
  "docs": { category:"documentation", description:"Documentation website source", port:3000, repo:"winrx-mm/docs" },
  "termux-tools": { category:"termux", description:"Termux command-line tools", repo:"winrx20/termux-tools" },
  "termux-packages": { category:"termux", description:"Termux package build system", repo:"winrx20/termux-packages" }
};
const apps = document.querySelector('#apps');
const search = document.querySelector('#search');
const category = document.querySelector('#category');
const toast = document.querySelector('#toast');
Object.values(registry).forEach(app => { if (!Array.from(category.options).some(o => o.value === app.category)) category.add(new Option(app.category, app.category)); });
function render() {
  const query = search.value.toLowerCase(); const selected = category.value;
  const entries = Object.entries(registry).filter(([name, app]) => (!query || `${name} ${app.description}`.toLowerCase().includes(query)) && (selected === 'all' || app.category === selected));
  apps.innerHTML = entries.length ? entries.map(([name, app]) => `<article class="card"><span class="badge">${app.category}</span><h2>${name}</h2><p>${app.description}</p><div class="card-footer"><code>${app.port ? `localhost:${app.port}` : 'CLI module'}</code><a class="link" href="https://github.com/${app.repo}" target="_blank" rel="noreferrer">GitHub ↗</a></div></article>`).join('') : '<div class="empty">No projects match your search.</div>';
  document.querySelector('#stats').innerHTML = `<div class="stat"><strong>${Object.keys(registry).length}</strong><span>projects registered</span></div><div class="stat"><strong>${Object.values(registry).filter(a => a.category === 'web' || a.category === 'service').length}</strong><span>web and service apps</span></div><div class="stat"><strong>${Object.values(registry).filter(a => a.category === 'termux' || a.category === 'cli').length}</strong><span>Termux and CLI tools</span></div>`;
}
function showToast(text) { toast.textContent = text; toast.classList.add('show'); setTimeout(() => toast.classList.remove('show'), 2200); }
search.addEventListener('input', render); category.addEventListener('change', render); document.querySelector('#refresh').addEventListener('click', () => { render(); showToast('Dashboard refreshed'); });
document.querySelector('#copyBootstrap').addEventListener('click', async () => { await navigator.clipboard.writeText('pkg update -y && pkg install -y git python nodejs npm golang && git clone https://github.com/winrx20/winrx-hub.git && cd winrx-hub && bash install.sh && bash bootstrap.sh && export PATH="$PWD/bin:$PATH" && winrx status'); showToast('Termux setup copied'); });
render();
