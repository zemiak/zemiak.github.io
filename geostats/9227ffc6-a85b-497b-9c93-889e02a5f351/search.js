class SearchForHiddenCaches {
    constructor(cacher, cacheType, year, month, day) {
        this.cacher = cacher;
        this.cacheType = cacheType;
        this.year = year;
        this.month = month;
        this.day = day;
    }

    buildUrl() {
        return "https://www.geocaching.com/api/proxy/web/search/v2"
            + "?take=200&asc=true&sort=distance&rad=100000&origin=48.14816,17.10674"
            + "&pod=" + this.zeroPad(this.year, 1000) + "-" + this.zeroPad(this.month, 10) + "-" + this.zeroPad(this.day, 10)
            + "&ct=" + this.cacheType + "&nfb=" + this.cacher;
    }

    zeroPad(nr, base) {
        var len = (String(base).length - String(nr).length) + 1;
        return len > 0 ? new Array(len).join('0') + nr : nr;
    }

    search() {
        let url = this.buildUrl();
        // read json array using fetch
        let caches = fetch(url)
            .then(response => response.json())
            .then(data => {
                let caches = [];
                for (let i = 0; i < data.results.length; i++) {
                    let cache = data.results[i];
                    caches.push(cache);
                }

                console.log("Found " + caches.length + " caches for " + this.cacher + " in " + this.year + "-" + this.month + "-" + this.day + " of type " + this.cacheType);
            }).catch(error => {
                console.error('Error fetching geocaches from search:', error);
            });


        return caches;
    }
}

document.addEventListener("DOMContentLoaded", () => {
    // const urlParams = new URLSearchParams(window.location.search);
    // const searchType = urlParams.get('type');

    // if (searchType === 'hidden') {
    //     const cacheType = urlParams.get('cacheType');
    //     const cacher = urlParams.get('cacher');
    //     const month = urlParams.get('month');
    //     const day = urlParams.get('day');

    //     // loop from current year downwards to 2000
    //     for (let year = new Date().getFullYear(); year >= 2000; year--) {
    //         if (year === 2000 && fromMonth < 5) {
    //             continue;
    //         }

    //         new SearchForHiddenCaches(cacher, cacheType, year, month, day).search();
    //     }
    // } else {
    //     console.error("Unknown search type: " + searchType);
    // }


    const loginUrl = "https://www.geocaching.com/account/signin";
const searchUrl = "https://www.geocaching.com/api/proxy/web/search";

const email = "zemiacik52";
const password = "debian";
const searchQuery = "New York";
const searchType = "Traditional";

// First, log in to geocaching.com and get the cookies
fetch(loginUrl, {
  method: "POST",
  headers: {
    "Content-Type": "application/x-www-form-urlencoded"
  },
  body: `Email=${email}&Password=${password}&PersistLogin=true`
})
.then(response => {
  if (!response.ok) {
    throw new Error("Failed to log in");
  }
  // Get the login cookies from the response headers
  const cookies = response.headers.get("set-cookie");
  // Use the cookies to search for geocaches
  return fetch(`${searchUrl}?q=${searchQuery}&st=${searchType}`, {
    headers: {
      Cookie: cookies
    }
  });
})
.then(response => {
  if (!response.ok) {
    throw new Error("Failed to search for geocaches");
  }
  // Get the search results from the response body
  return response.json();
})
.then(searchResults => {
  console.log("Search successful", searchResults);
})
.catch(error => {
  console.error("Error:", error.message);
});


});
