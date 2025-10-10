<script setup>
import { Head, Link } from '@inertiajs/vue3';
import AppFooter from '@/Components/AppFooter.vue';
import { ref } from 'vue';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  laravelVersion: {
    type: String,
    required: true,
  },
  phpVersion: {
    type: String,
    required: true,
  },
});

const isMobileMenuOpen = ref(false);
const toggleMobileMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
};
</script>

<template>

  <Head title="Home" />
  <div class="welcome-container">
    <!-- Navigation -->
    <nav class="navbar">
      <div class="logo">
        <img src="/assets/caa-logo.png" alt="CAA Logo" class="logo-img" />
        Civil Aviation Authority
      </div>

      <!-- Hamburger Button for Mobile -->
      <button class="hamburger" @click="toggleMobileMenu">
        <span :class="{ 'line': true, 'line1': true, 'active': isMobileMenuOpen }"></span>
        <span :class="{ 'line': true, 'line2': true, 'active': isMobileMenuOpen }"></span>
        <span :class="{ 'line': true, 'line3': true, 'active': isMobileMenuOpen }"></span>
      </button>

      <!-- Nav Links -->
      <ul :class="['nav-links', { 'mobile-open': isMobileMenuOpen }]">
        <li>
          <Link :href="route('welcome')" class="active">Home</Link>
        </li>
        <!-- <li>
          <Link :href="route('aboutPage')">About us</Link>
        </li> -->
        <li>
          <a href="https://www.caa.co.zm/about-us" target="_blank" rel="noopener noreferrer">
            About Us
          </a>
        </li>


        <template v-if="canLogin">
          <li v-if="$page.props.auth?.user">
            <Link :href="route('dashboard')">Dashboard</Link>
          </li>
          <template v-else>
            <li>
              <Link :href="route('login')">Login</Link>
            </li>
            <li v-if="canRegister">
              <Link :href="route('register')">Register</Link>
            </li>
          </template>
        </template>

        <!-- <li>
          <Link :href="route('contactPage')" class="contact-btn spaced-link">
          Contact us
          </Link>
        </li> -->
         <li>
          <a href="https://www.caa.co.zm/contact-us" target="_blank" rel="noopener noreferrer" class="contact-btn spaced-link">
            Contact Us
          </a>
        </li>

        

      </ul>
    </nav>

    <!-- Hero Section -->
    <section class="hero">
      <img src="/assets/background.jpg" alt="Aviation security infomation" class="hero-bg" />

      <div class="hero-content">
        <h1>Aviation Security Information Management System (ASIMS)</h1>
        <p>
          ASIMS is a system that manages, monitors and report security quality controls in
          order to enhance security compliance & surveillance.
        </p>
        <div class="hero-buttons">
          <button class="primary-btn">Learn More</button>
          <!-- <button class="secondary-btn">Learn More</button> -->
        </div>
      </div>
    </section>
  </div>

  <!-- Footer -->
  <AppFooter />
</template>

<style scoped>
/* Container */
.welcome-container {
  width: 100%;
  min-height: 100vh;
  background-color: #000;
  color: #fff;
  /* font-family: "Arial", sans-serif; */
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  /* Updated font */
  display: flex;
  flex-direction: column;
}

/* Navbar */
.navbar {
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
  padding: 20px 50px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 10;
}

/* Logo */
.logo {
  font-size: 22px;
  font-weight: bold;
  display: flex;
  align-items: center;
  gap: 10px;
}

.logo-img {
  height: 40px;
  width: auto;
}

/* Nav links */
.nav-links {
  list-style: none;
  display: flex;
  gap: 30px;
  align-items: center;
}

.nav-links li a,
.nav-links li :deep(a) {
  text-decoration: none;
  color: #fff;
  font-size: 16px;
  transition: color 0.3s;
}

.nav-links li a:hover,
.nav-links li :deep(a:hover) {
  color: #ddd;
}

.nav-links li a.active {
  border: 1px solid #fff;
  padding: 6px 15px;
  border-radius: 20px;
}

.contact-btn {
  background: #3f3e3e;
  color: #000;
  border: none;
  padding: 8px 18px;
  border-radius: 20px;
  cursor: pointer;
  font-weight: bold;
  transition: 0.3s ease;
}

.contact-btn:hover {
  background: #b4b2b2;
}

/* Hamburger Menu */
.hamburger {
  display: none;
  flex-direction: column;
  justify-content: space-between;
  width: 25px;
  height: 20px;
  background: none;
  border: none;
  cursor: pointer;
  z-index: 20;
}

.hamburger .line {
  height: 3px;
  width: 100%;
  background: #fff;
  transition: all 0.3s ease;
}

.hamburger .line1.active {
  transform: rotate(45deg) translateY(7px);
}

.hamburger .line2.active {
  opacity: 0;
}

.hamburger .line3.active {
  transform: rotate(-45deg) translateY(-7px);
}

/* Mobile styles */
@media (max-width: 768px) {
  .hamburger {
    display: flex;
  }

  .nav-links {
    position: absolute;
    top: 80px;
    left: 0;
    right: 0;
    background: rgba(0, 0, 0, 0.95);
    flex-direction: column;
    gap: 20px;
    padding: 20px;
    display: none;
  }

  .nav-links.mobile-open {
    display: flex;
  }

  .nav-links li a,
  .nav-links li :deep(a) {
    font-size: 18px;
  }

  .contact-btn {
    width: 100%;
    text-align: center;
  }
}

/* Hero Section */
.hero {
  position: relative;
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: flex-start;
}

.hero-bg {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100vh;
  object-fit: cover;
  z-index: 0;
  filter: brightness(0.6);
}

.hero-content {
  position: relative;
  z-index: 1;
  padding: 0 50px;
  max-width: 700px;
}

.hero-content h1 {
  font-size: 48px;
  font-weight: bold;
  margin-bottom: 20px;
}

.hero-content p {
  font-size: 18px;
  margin-bottom: 30px;
  line-height: 1.5;
}

.hero-buttons {
  display: flex;
  gap: 15px;
}

.primary-btn,
.secondary-btn {
  padding: 12px 25px;
  border-radius: 25px;
  border: none;
  font-size: 16px;
  cursor: pointer;
  font-weight: bold;
}

.primary-btn {
  background: #fff;
  color: #000;
}

.secondary-btn {
  background: transparent;
  border: 1px solid #fff;
  color: #fff;
}

.spaced-link {
  margin-left: 40px;
  /* Adjust the spacing as needed */
}


@keyframes slideIn {
  0% {
    opacity: 0;
    transform: translateX(-80%);
  }
  15% {
    opacity: 1;
    transform: translateX(0);
  }
  70% {
    opacity: 1;
    transform: translateX(0);
  }
  100% {
    opacity: 0;
    transform: translateX(80%);
  }
}

.hero-content h1,
.hero-content p {
  animation: slideIn 10s ease-in-out infinite;
}

/* Slight delay for paragraph for a flowing effect */
.hero-content p {
  animation-delay: 1s;
}


</style>
