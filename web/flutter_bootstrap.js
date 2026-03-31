{{flutter_js}}
{{flutter_build_config}}

// ─── Performance-tuned Flutter Bootstrap ────────────────────────────────────
// Strategy:
//  1. Show HTML splash immediately (already visible from index.html)
//  2. Initialize Flutter with the fastest available renderer:
//     • skwasm (WasmGC + multi-thread) when COOP/COEP headers are set
//     • Falls back to canvaskit automatically for older browsers
//  3. Use serviceWorker for aggressive caching on repeat visits
// ─────────────────────────────────────────────────────────────────────────────

_flutter.loader.load({
  // Tell the loader which renderer to prefer.
  // "auto" lets Flutter pick skwasm if the browser supports it,
  // otherwise falls back to canvaskit. This is the recommended setting.
  webRenderer: "auto",

  onEntrypointLoaded: async function(engineInitializer) {
    // Initialize the Flutter engine
    const appRunner = await engineInitializer.initializeEngine({
      // Use a single-element canvas to avoid extra DOM overhead
      useColorEmoji: false,
    });

    // Run the app — Flutter will fire 'flutter-first-frame' when done
    await appRunner.runApp();
  }
});
