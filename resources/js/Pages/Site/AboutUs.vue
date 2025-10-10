<script>
import AppFooter from '@/Components/AppFooter.vue';
import { Head } from '@inertiajs/vue3';

export default {
    name: "AboutHistory",
    components: {
        Head,
        AppFooter,

    },
};
</script>

<template>

    <Head title="About" />
    <div class="about-us-page">
        <!-- Hero Section -->
        <section class="hero">
            <img class="hero-image" src="/assets/register-2.jpg" alt="About Us" />
            <div class="hero-content">
                <h2>About Us</h2>
                <p>
                    Our mission is to provide aviation authorities and stakeholders with the
                    critical security information and tools they need to ensure safe, efficient,
                    and secure air travel.
                </p>
            </div>
        </section>

        <!-- Our Story Section -->
        <section class="our-story">
            <h2>Our Story</h2>
            <div class="story-grid">
                <div class="story-card">
                    <h3>About Aviation Security</h3>
                    <p>
                        Aviation Security in Zambia ensures the safety of passengers, crew,
                        and airports by preventing unlawful interference with aircraft operations.
                        It involves screening, monitoring, and enforcing security measures to maintain
                        safe and secure air travel across the country.
                    </p>
                </div>
                <div class="story-card">
                    <h3>Our Mission</h3>
                    <p>
                        To ensure the safety and security of civil aviation in Zambia by providing reliable
                        security information, effective monitoring, and proactive measures against threats."
                    </p>
                </div>
                <div class="story-card">
                    <h3>Our Vision</h3>
                    <p>
                        To be Zambia’s leading authority in aviation security, fostering safe, secure, and
                        efficient air travel for all passengers and stakeholders.
                    </p>
                </div>
            </div>
        </section>

        <!-- Footer Component -->
        <AppFooter />

    </div>
</template>

<style scoped>
.about-us-page {
    /* font-family: 'Arial', sans-serif; */
    font-family: 'Poppins', 'Segoe UI', sans-serif;
    /* Updated font */
    color: #333;
}

/* Hero Section */
.hero {
    position: relative;
    width: 100%;
    height: 400px;
    /* reduced height */
    display: flex;
    align-items: center;
    overflow: hidden;
}

.hero-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1;
    filter: brightness(70%);
    /* darker overlay for better text readability */
}

.hero-content {
    max-width: 600px;
    margin-left: 5%;
    color: #fff;
}

.hero-content h2 {
    font-size: 42px;
    font-weight: 700;
    margin-bottom: 15px;
}

.hero-content p {
    font-size: 18px;
    line-height: 1.6;
}

/* Our Story Section */
.our-story {
    padding: 60px 10%;
    text-align: center;
    background-color: #f7f7f7;
}

.our-story h2 {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 40px;
}

.story-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

.story-card {
    text-align: left;
    background-color: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.story-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.story-card h3 {
    font-size: 20px;
    margin-bottom: 10px;
    font-weight: 600;
}

.story-card p {
    font-size: 15px;
    line-height: 1.6;
    color: #555;
}

/* Responsive Styles */
@media (max-width: 992px) {
    .hero-content {
        margin-left: 5%;
    }

    .story-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .hero {
        height: 300px;
        justify-content: center;
        text-align: center;
    }

    .hero-content {
        margin-left: 0;
        max-width: 90%;
    }

    .hero-content h2 {
        font-size: 32px;
    }

    .hero-content p {
        font-size: 16px;
    }

    .story-grid {
        grid-template-columns: 1fr;
    }
}
</style>
