// Runtime configuration, loaded before the app bundle (see src/app.html).
//
// This file is deliberately NOT bundled by Vite so it can be swapped after the build without
// recompiling anything:
//   - Kubernetes: a ConfigMap is mounted over this file's path in the running container.
//   - GitHub Pages: a different config.js is published alongside index.html/assets in the same
//     folder as this default one.
window.APP_CONFIG = {
	DB_URL: 'https://zemiak.github.io/geostats/9227ffc6-a85b-497b-9c93-889e02a5f351/my-finds.db',
	LAB_COUNT: 1121
};
