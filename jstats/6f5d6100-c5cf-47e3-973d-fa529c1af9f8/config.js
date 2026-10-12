// Runtime configuration, loaded before the app bundle (see src/app.html).
//
// This file is deliberately NOT bundled by Vite so it can be swapped after the build without
// recompiling anything:
//   - Kubernetes: a ConfigMap is mounted over this file's path in the running container.
//   - GitHub Pages: a different config.js is published alongside index.html/assets in the same
//     folder as this default one.
window.APP_CONFIG = {
	// Databases offered on /databases; the first is active until another is picked there.
	//   type: 'db' (SQLite built by geostats), 'gpx' or 'zip' (a geocaching.com Pocket Query, converted
	//         to SQLite in the browser) — inferred from the URL's extension when left out.
	//   cacher: whose "Found it" logs give the find dates of a GPX/ZIP (default: CACHER below).
	//   labCount: LAB caches found, added to the found count on /info.
	DATABASES: [
		{
			name: 'My finds',
			url: 'https://zemiak.github.io/geostats/9227ffc6-a85b-497b-9c93-889e02a5f351/my-finds.db',
			labCount: 1121
		}
		// { name: 'Slovakia', url: 'https://example.com/slovakia.zip', type: 'zip' }
	],
	CACHER: 'zemiak',
	// Read-only filters offered on /filter above the ones a user saves themselves. `filter` uses the
	// same text as the Expression field on /filter, e.g. `(type=multi or type=unknown) and d>=3`.
	DEFAULT_FILTERS: [
		{ name: 'Puzzles & multis', filter: 'type=multi or type=unknown' },
		{ name: 'Hiking caches', filter: 'attr=hiking' },
		{ name: 'High terrain (T4+)', filter: 't>=4' },
		{ name: 'Hard puzzles (D4+)', filter: 'type=unknown and d>=4' },
		{ name: 'Events', filter: 'type=events' },
		{ name: 'Slovakia, not traditional', filter: 'country=slovakia and type!=traditional' }
	]
};
