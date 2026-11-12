<script lang="ts">
import { isEnvBrowser } from '$lib/utils/misc';

if (isEnvBrowser()) {
    const root = document.getElementById('app');

    // https://i.imgur.com/iPTAdYV.png - Night time img
    root!.style.backgroundImage = 'url("https://i.imgur.com/3pzRj9n.png")';
    root!.style.backgroundSize = 'cover';
    root!.style.backgroundRepeat = 'no-repeat';
    root!.style.backgroundPosition = 'center';
}

function onKeyDown(event: KeyboardEvent) {
    const key = event.key.toLowerCase();

    switch (key) {
        // Key handlers
    }
}
</script>


<!-- Main container for report system -->
<div class="container">
    
</div>