import '../css/app.css';
import './bootstrap';

import { createInertiaApp } from '@inertiajs/vue3';
import { resolvePageComponent } from 'laravel-vite-plugin/inertia-helpers';
import { createApp, h } from 'vue';
import { ZiggyVue } from '../../vendor/tightenco/ziggy';
import VueSweetalert2 from 'vue-sweetalert2';

const appName = import.meta.env.VITE_APP_NAME || 'Laravel';

// Inject the preloader div
const loader = document.createElement('div');
loader.id = 'preloader';
loader.innerHTML = `<img src="/assets/caa-logo.png" alt="Loading Logo" />`;
document.body.appendChild(loader);

// Track load start time
const startTime = Date.now();

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob('./Pages/**/*.vue'),
        ),
    setup({ el, App, props, plugin }) {
        const app = createApp({ render: () => h(App, props) })
            //.use(router)
            .use(VueSweetalert2)
            .use(plugin)
            .use(ZiggyVue);

        app.mount(el);

        // Fade out the preloader after minimum display time
        const MIN_DISPLAY_TIME = 2500;
        const elapsed = Date.now() - startTime;
        const remaining = Math.max(0, MIN_DISPLAY_TIME - elapsed);

        setTimeout(() => {
            const preloader = document.getElementById('preloader');
            if (preloader) {
                preloader.classList.add('fade-out');
                setTimeout(() => preloader.remove(), 1000); // match transition duration
            }
        }, remaining);

        return app;
    },
    progress: {
        color: '#4B5563',
    },
});