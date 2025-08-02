'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "1e45b12dcc67350902ee595eb033463a",
"version.json": "2a4bdd3370ee966319e180d97d91e050",
"index.html": "77c0c6d6706ef245488fd98eec0e8392",
"/": "77c0c6d6706ef245488fd98eec0e8392",
"main.dart.js": "0dda7ef563cd8ff36d245590da6e22f3",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "1cff6c2680d1661b000e5cc689a02ada",
"icons/Icon-192.png": "1cff6c2680d1661b000e5cc689a02ada",
"icons/Icon-maskable-192.png": "1cff6c2680d1661b000e5cc689a02ada",
"icons/Icon-maskable-512.png": "1cff6c2680d1661b000e5cc689a02ada",
"icons/Icon-512.png": "1cff6c2680d1661b000e5cc689a02ada",
"manifest.json": "37bf055b9c9765d74707c25b1e247814",
"assets/AssetManifest.json": "7a6c00bbc1230cad239c9553a9befda7",
"assets/NOTICES": "0924bd054de75924b2fd2574eea0233d",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/AssetManifest.bin.json": "a1388d4295ecc48fea3de63064c5c358",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "284e2214ebfbe765b3ec61e23192eb4e",
"assets/fonts/MaterialIcons-Regular.otf": "d4b5014fd98c84c4d84269e8528f9907",
"assets/assets/images/rentx-logo.png": "26f80235194de9092189703aef2847a3",
"assets/assets/images/marketplace-logo.png": "b399026b01d490d2d9053d58237a5187",
"assets/assets/images/lahzi-logo.png": "704c655d64be82968d72242ea667752f",
"assets/assets/images/alpha-logo.png": "2fcc9480cd65b9de0bd3e91303c914d9",
"assets/assets/images/personal-pic.png": "1cff6c2680d1661b000e5cc689a02ada",
"assets/assets/images/chaqt-logo.png": "5c8f4e834aa6e6d31a1dcf61dc38f9e1",
"assets/assets/svgs/search.svg": "9092c17e2cfde3357a45f8bc570bcaf7",
"assets/assets/svgs/drag-and-drop.svg": "75e970dbe26dc3f96dbba4515b87a196",
"assets/assets/svgs/earning.svg": "9f78eceec9752929ced2d3fa882b6f6d",
"assets/assets/svgs/chats_icon.svg": "dd427b0722891cfe254386a69a7f2d2a",
"assets/assets/svgs/requests_icon_filled.svg": "6058bbccae8f40723ce6a4b4018305f6",
"assets/assets/svgs/settings_1.svg": "4e1ed9ae9ec0b87f90ca0c5423113b0c",
"assets/assets/svgs/microphone.svg": "aaf8768360b80f2606d64d630bf1e994",
"assets/assets/svgs/verified.svg": "1e4400183f3ecefdd4c38bdc16a69016",
"assets/assets/svgs/drag.svg": "287d3c64f50b0d00b50b9c08fb280007",
"assets/assets/svgs/lock.svg": "68a9a558ee3f4173685b7d3ce843e3d8",
"assets/assets/svgs/app_icon.svg": "856bae418e7809b07bf9f17c9362b555",
"assets/assets/svgs/instagram.svg": "f1e2e42c5f7370024440233a9fd0e7f0",
"assets/assets/svgs/policy.svg": "ce0a55011461a35b65e28821f842ba36",
"assets/assets/svgs/settings.svg": "51e9d66ddc089a1fc1109333928e79a0",
"assets/assets/svgs/profile_icon.svg": "344c1bb02669e161a4380266174c8cbd",
"assets/assets/svgs/play_inverted_colors.svg": "890f537c6bad4587b73ff06f2910614c",
"assets/assets/svgs/other_social.svg": "3ef2b4818eec4f5118bc81716200e9c9",
"assets/assets/svgs/google_icon.svg": "3d6035d8fa4c3cfe92a92c840cfc4c62",
"assets/assets/svgs/requests_icon.svg": "d170fcb990fe194c97432f42edf53de5",
"assets/assets/svgs/biometric.svg": "1171d9466aafbe8f6bf6857a339a9121",
"assets/assets/svgs/second_arrow_right.svg": "724e565066a4288f5a99551f1f7ce9d1",
"assets/assets/svgs/wallet.svg": "324c7a73703a33493153ba09ca6f8e0c",
"assets/assets/svgs/ios-drag.svg": "a857027e06902a13ef3a517fcd00c5ba",
"assets/assets/svgs/chats_icon_filled.svg": "885572890464a9bcb41d331ade0d2a71",
"assets/assets/svgs/verification.svg": "cd0ebac2466646021485b2f61fbfc358",
"assets/assets/svgs/arrow_right.svg": "09a1b056e777fe04b7ec670fa4d113da",
"assets/assets/svgs/payout.svg": "ec80536f386f5acc7d3eaf67b9d3eb51",
"assets/assets/svgs/pause_inverted_colors.svg": "7ba284d4108f85930f3586dc604bb415",
"assets/assets/svgs/profile_link.svg": "3f704829dee1b3bf6440661d5599abd7",
"assets/assets/svgs/add.svg": "42c13d60b73dd59f26f795570ff0608c",
"assets/assets/svgs/subscription.svg": "f25bbac0807cbc584261c487b2c629c5",
"assets/assets/svgs/copy.svg": "4e211e0c4d2d3cb6da41ea1725042740",
"assets/assets/svgs/other_social1.svg": "c09f44ed868b06b42b3647571edf3bae",
"assets/assets/svgs/terms-conditions.svg": "bb0c552e1b3beba18f89c432074f1465",
"assets/assets/svgs/request_accepted_charts.svg": "0464cf087759a526e4c5c0fb27002e12",
"assets/assets/svgs/report.svg": "9827e254c0bc5957e01c32ee7c185d4d",
"assets/assets/svgs/play.svg": "be9d9b8cb2faf184924aa1e9ec643080",
"assets/assets/svgs/notification.svg": "8f72f3cee43a725bf18562e9a6468f4c",
"assets/assets/svgs/paypal.svg": "5d47d2eaaea41e42df7193425c915910",
"assets/assets/svgs/coin.svg": "80909cc77fc6749d5cdfcbd7b5f4a340",
"assets/assets/svgs/facebook.svg": "af6284f6eeb04bf30a900524adbfa3c8",
"assets/assets/svgs/camera.svg": "7874ccaa25a934a4ffb0c62b60e3c559",
"assets/assets/svgs/faceId.svg": "546437791d075c576dd40ad8c252af05",
"assets/assets/svgs/no_data.svg": "b1c963998a23956e0d82ae5dbeae5d0e",
"assets/assets/svgs/customer_services.svg": "91f815a630e5fea89a17d33be3169cd9",
"assets/assets/svgs/whatsapp.svg": "e10e21d8183da9313051969840120e0d",
"assets/assets/svgs/about.svg": "7edf4639f320681967331d741f03b159",
"assets/assets/svgs/email2.svg": "d3114aae40b56136c994c445a6bd3348",
"assets/assets/svgs/telephone.svg": "8a8989c848cb068a8b88098f8c6a207a",
"assets/assets/svgs/edit.svg": "c515e4e275cf5f6398406557fe03582b",
"assets/assets/svgs/contact_us.svg": "cc32f83ae9b6c12e63b684bcc676abd8",
"assets/assets/svgs/linkedin.colored.svg": "369d32a66adc75a362347d7e446d4f03",
"assets/assets/svgs/language.svg": "069bd71fdbcf7597fff8507433a2ebb7",
"assets/assets/svgs/delete.svg": "a6029d89ae840aabdd190b830a3ae9fc",
"assets/assets/svgs/clock.svg": "1a4f2377ec8cde9c08e879cc89d4130c",
"assets/assets/svgs/settings_filled.svg": "da1961e61b63ce6f008ddfae83018343",
"assets/assets/svgs/share.svg": "11cc516fc78c2fc5fd6ca322b8492a40",
"assets/assets/svgs/linkedin.svg": "21a464a975f56c431e99cfb5767803f0",
"assets/assets/svgs/twitter.svg": "e909be332f183c44836998a60efa8f11",
"assets/assets/svgs/apple_icon.svg": "2fd4ef6367714c8ec88347b39fe4f090",
"assets/assets/svgs/profile_icon_filled.svg": "b768da5c213ce5dab3929d8a9a31cd40",
"assets/assets/svgs/messenger.svg": "173184a385ad4be9f22926f76d94da84",
"assets/assets/svgs/pause.svg": "ee3054b040656e4248c5724422dc5fc3",
"assets/assets/svgs/message_sent_check.svg": "55bf830c9982699a285589e7d716bdde",
"assets/assets/svgs/mail2.svg": "e2d0b4aac3bb3bd7f981627e9e4f8a2c",
"assets/assets/svgs/person_add.svg": "890b3fcb716a1bbfa1212586119d7609",
"assets/assets/svgs/price.svg": "783878fd6d28912f383fb629ee45c408",
"assets/assets/svgs/tiktok.svg": "ff61b502321f5adcd6625ae32ae445e3",
"assets/assets/svgs/finger_print.svg": "8548d146a42805e5c101aaecc46a2338",
"assets/assets/files/mohamed-mounir-flutter-cv.pdf": "8e52c2b3d2d26af1d93b4c2490175283",
"assets/assets/translations/en.json": "f3d7fa80879d537e92678904590fdbcf",
"assets/assets/translations/ar.json": "0c21c599c4a175654c1a33399f1dd6b2",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
