// sw.js - Service Worker za caching
const CACHE_NAME = 'pulsgel-cache-v1';
const urlsToCache = [
  './',
  './index.html',
  './slika1.webp',
  './nauka/index.html',
  './blog/ph-vrednost/index.html',
  './blog/prirodni-sastojci/index.html'
];

self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});
