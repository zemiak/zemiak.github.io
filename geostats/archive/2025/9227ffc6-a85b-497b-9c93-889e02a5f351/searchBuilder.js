/*
 JavaScript version of com.zemiak.search.SearchBuilder
 - Builds Geocaching.com search URLs
 - Mirrors the Java API where practical
 - Safe to use directly in browser templates
*/
(function (global) {
	'use strict';

	function encode(v) {
		return encodeURIComponent(String(v));
	}

	function isDateLike(v) {
		return v instanceof Date || (typeof v === 'string' && /^\d{4}-\d{2}-\d{2}$/.test(v));
	}

	function toDateStr(v) {
		if (v instanceof Date) {
			// YYYY-MM-DD from ISO
			return v.toISOString().slice(0, 10);
		}
		return String(v);
	}

	class SearchBuilder {
		constructor() {
			this.searchParams = [
				'r=10',
				'oid=-1',
				'ot=home',
				'hf=1',
				'ho=1',
			];
		}

		// Internal helpers
		removeExact(entry) {
			this.searchParams = this.searchParams.filter((p) => p !== entry);
		}

		addParam(k, v) {
			this.searchParams.push(`${k}=${v}`);
			return this;
		}

		// Keep API parity with Java version
		cacherName(name) {
			// If name omitted, try a global fallback (optional)
			if (typeof name === 'undefined' || name === null) {
				const fallback = global.GEOSTATS_CACHER || (global.GEOSTATS && global.GEOSTATS.cacher);
				if (!fallback) return this; // no-op when unknown
				name = fallback;
			}
			return this.addParam('nfb', encode(name));
		}

		// Java has an overload without args; expose a named helper for clarity
		typeAllEvents() {
			// Use the same pre-encoded value to match Java output exactly
			return this.addParam('ct', '6%2C1304%2C3653%2C3774%2C4738%2C453%2C7005%2C13');
		}

		type(typeOrCode) {
			let code = typeOrCode;
			if (typeOrCode && typeof typeOrCode.getCode === 'function') {
				code = typeOrCode.getCode();
			} else if (typeOrCode && typeof typeOrCode === 'object' && 'code' in typeOrCode) {
				code = typeOrCode.code;
			}
			return this.addParam('ct', encode(code));
		}

		country(name, oid /* optional */) {
			this.removeExact('ot=home');
			this.removeExact('oid=-1');
			this.addParam('ot', 'country');
			this.addParam('st', encode(name));
			if (oid !== undefined && oid !== null) {
				this.addParam('oid', String(oid));
			}
			return this;
		}

		placedBetween(from, to) {
			if (!isDateLike(from) || !isDateLike(to)) return this;
			this.addParam('psd', toDateStr(from));
			this.addParam('ped', toDateStr(to));
			return this;
		}

		placedOn(on) {
			if (!isDateLike(on)) return this;
			return this.addParam('pod', toDateStr(on));
		}

		difficulty(difficulty) {
			return this.addParam('d', String(difficulty));
		}

		terrain(terrain) {
			return this.addParam('t', String(terrain));
		}

		terrains(...vals) {
			const list = Array.isArray(vals[0]) ? vals[0] : vals;
			return this.addParam('t', list.map(String).join(','));
		}

		difficulties(...vals) {
			const list = Array.isArray(vals[0]) ? vals[0] : vals;
			return this.addParam('d', list.map(String).join(','));
		}

		attributes(...attrs) {
			const list = Array.isArray(attrs[0]) ? attrs[0] : attrs;
			const ids = list.map((a) => (a && typeof a === 'object' && 'id' in a ? a.id : a)).map(String);
			return this.addParam('att', ids.join(','));
		}

		size(size) {
			// Accept object with code or raw code
			const code = size && typeof size === 'object' && 'code' in size ? size.code : size;
			return this.addParam('cs', String(code));
		}

		county(countryName, countyName) {
			this.removeExact('ot=home');
			this.removeExact('oid=-1');
			this.addParam('ot', 'city');
			this.addParam('st', encode(`${countyName}, ${countryName}`));
			return this;
		}

		build() {
			return 'https://www.geocaching.com/play/results?' + this.searchParams.join('&');
		}

		// Convenience: open the built URL
		open() {
			const url = this.build();
			if (typeof window !== 'undefined' && window.location) {
				window.location.href = url;
			}
			return url;
		}
	}

	// Export
	if (typeof module !== 'undefined' && module.exports) {
		module.exports = SearchBuilder;
	}
	global.SearchBuilder = SearchBuilder;
})(typeof window !== 'undefined' ? window : globalThis);
