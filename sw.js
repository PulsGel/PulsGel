const CACHE_VERSION = 'v2';
const IMAGE_CACHE = 'images-v1';
const STATIC_CACHE = 'static-v1';

const IMAGES_TO_CACHE = [
    '/PulsGel/slika1.webp',
    '/PulsGel/favicon.ico'
];

const STATIC_TO_CACHE = [
    '/PulsGel/',
    '/PulsGel/index.html',
    '/PulsGel/nauka/',
    '/PulsGel/blog/ph-vrednost/',
    '/PulsGel/blog/prirodni-sastojci/'
];

self.addEventListener('install', event => {
    event.waitUntil(
        Promise.all([
            caches.open(IMAGE_CACHE).then(cache => {
                return cache.addAll(IMAGES_TO_CACHE);
            }),
            caches.open(STATIC_CACHE).then(cache => {
                return cache.addAll(STATIC_TO_CACHE);
            })
        ]).then(() => self.skipWaiting())
    );
});

self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (![IMAGE_CACHE, STATIC_CACHE].includes(cacheName)) {
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => self.clients.claim())
    );
});

self.addEventListener('fetch', event => {
    const url = new URL(event.request.url);
    
    // Агресивно кеширање слика
    if (url.pathname.match(/\.(webp|jpg|jpeg|png|gif|ico|svg)$/i)) {
        event.respondWith(
            caches.match(event.request).then(cachedResponse => {
                if (cachedResponse) {
                    return cachedResponse;
                }
                
                return fetch(event.request).then(networkResponse => {
                    if (!networkResponse || networkResponse.status !== 200) {
                        return networkResponse;
                    }
                    
                    const responseToCache = networkResponse.clone();
                    
                    caches.open(IMAGE_CACHE).then(cache => {
                        cache.put(event.request, responseToCache);
                    });
                    
                    return networkResponse;
                });
            })
        );
        return;
    }
    
    event.respondWith(
        caches.match(event.request)
            .then(cachedResponse => cachedResponse || fetch(event.request))
    );
});
