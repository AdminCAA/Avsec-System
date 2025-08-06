<script setup>
import { Head, Link } from '@inertiajs/vue3';

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

function handleImageError() {
    document.getElementById('screenshot-container')?.classList.add('!hidden');
    document.getElementById('docs-card')?.classList.add('!row-span-1');
    document.getElementById('docs-card-content')?.classList.add('!flex-row');
    document.getElementById('background')?.classList.add('!hidden');
}
</script>
<template>
    
    <div class="welcome-container">
        <Head title="Welcome" />
      <header>
        <div class="logo">
            <img src="/assets/caa-logo.png" alt="PEL System Logo" style="width: 60px; height: auto;">
            <span>Zambia Civil Aviation Authority</span>
        </div>
        <div class="auth">
            <nav v-if="canLogin" class="-mx-3 flex flex-1 justify-end">
              <Link
                v-if="$page.props.auth.user"
                :href="route('dashboard')"
                class="rounded-md px-3 py-2 text-black ring-1 ring-transparent transition hover:text-black/70 focus:outline-none focus-visible:ring-[#FF2D20] dark:text-white dark:hover:text-white/80 dark:focus-visible:ring-white"
              >
                Dashboard
              </Link>
        
              <template v-else>
                <Link
                  :href="route('login')"
                  
                  class="btn btn-info px-3 py-1 mr-2"
                ><i class="nav-icon fas fa-sign-in-alt"></i>
                    Sign in
                </Link>
        
                <Link
                  v-if="canRegister"
                  :href="route('register')"
                    class="btn btn-info px-3 py-1"
                ><i class="nav-icon fas fa-user-plus"></i>
                
                  Register
                </Link>
              </template>
            </nav>
          </div>
      </header>
      <section class="hero">
        <div class="hero-content">
          <h1>
            <span class="slide-in word1">AVIATION SECURITY</span> <br>
            <span class="slide-in word2">INFORMATION MANAGEMENT</span> <br>
            <span class="slide-in word3">SYSTEM</span>
          </h1>
        </div>
      </section>
    </div>
  </template>
  
  <script>
  export default {
    name: "Welcome",
  };
  </script>
  
  <style scoped>
  /* General Styles */
  .welcome-container {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-image: url('/assets/full_1.jpg'); /* Background image path */
    background-size: cover; /* Makes the image cover the entire container */
    background-position: center; /* Centers the image */
    color: white;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}
  /* Header */
  header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 50px;
  }
  

  .logo {
    font-size: 20px;
    font-weight: bold;
    display: flex;
    color: rgba(245, 245, 245, 0.833);
    align-items: center; /* Vertically align the logo and text */
}

.logo img {
    margin-right: 10px; /* Optional: Adds space between the logo and the text */
}
  
  nav ul {
    list-style: none;
    padding: 0;
    display: flex;
  }
  
  nav ul li {
    margin: 0 15px;
  }
  
  nav ul li a {
    text-decoration: none;
    color: #bbb;
    font-size: 14px;
  }
  
  nav ul li a.active {
    color: white;
  }
  
  .auth {
    display: flex;
    align-items: center;
  }
  
  .auth a {
    color: white;
    text-decoration: none;
    margin-right: 20px;
  }
  
  .get-started {
    background: #2eca73;
    border: none;
    padding: 8px 15px;
    color: white;
    border-radius: 20px;
    font-size: 14px;
    cursor: pointer;
  }

 /* Hero Section */
.hero {
    display: flex;
    justify-content: center; /* Moves content to the right */
    align-items: center;
    height: 80vh;     
    color: white;
  }
  
  /* Hero Content */
  .hero-content {
    text-align: right; /* Align text to the right */
  }
  
  /* Slide-in animation for each word */
  .slide-in {
    font-size: 50px;
    font-weight: bold;
    letter-spacing: 2px;
    display: inline-block;
    animation: slideIn 1s ease-out forwards infinite;
  }
  
  /* Staggered Animations with Delay */
  .word1 {
    animation-delay: 0.3s;
    animation-duration: 15s; /* Repeat every 15s */
  }
  .word2 {
    animation-delay: 0.6s;
    animation-duration: 15s;
  }
  .word3 {
    animation-delay: 0.9s;
    animation-duration: 15s;
  }
  
  /* Keyframes for sliding effect */
  @keyframes slideIn {
    0% {
      opacity: 0;
      transform: translateX(100%);
    }
    10% {
      opacity: 1;
      transform: translateX(0);
    }
    90% {
      opacity: 1;
      transform: translateX(0);
    }
    100% {
      opacity: 0;
      transform: translateX(-100%);
    }
  }

  .hero-content {
    max-width: 800px; /* Limits text width */
    text-align: right;
  }
  
  .hero h1 {
    font-size: 50px;
    letter-spacing: 10px;
    text-align: center;
    color: rgba(245, 245, 245, 0.833);
  }
  
  .text-box {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin: 20px 0;
  }
  
  .create-things {
    border: 2px solid white;
    padding: 10px;
    display: flex;
    flex-direction: column;
    text-align: center;
    font-weight: bold;
    font-size: 20px;
  }
  
  .white-text {
    color:white;
  }
  
  .amazing {
    border: 3px solid maroon;
    color: maroon;
    font-weight: bold;
    font-size: 20px;
    padding: 15px;
    margin-left: 10px;
  }
  
  .description {
    font-size: 14px;
    color: #ddd;
    line-height: 1.6;
  }
  
  .see-work {
    background: none;
    border: 2px solid white;
    padding: 10px 20px;
    color: white;
    cursor: pointer;
    margin-top: 20px;
  }

    button:not(:disabled) {
        cursor: pointer;
        border-radius: 1.5rem;
       
        background-color: #6d7af3;
    }
    button:hover {
        background-color: #2E5077;
        color: white;
    }
  </style>
  