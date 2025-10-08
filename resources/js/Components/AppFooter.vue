<!-- <template>    
 
  <footer class="main-footer">    
    <span>Copyright &copy; 2025 <a href="https://www.caa.co.zm">Zambia Civil Aviation Authority</a>.</span> All rights reserved.
  </footer>
</template>
<script>
    export default {
        
    }
</script> -->


<template>
    <footer class="footer">
        <div class="footer-container">
            <!-- Logo + Description -->
            <!-- <div class="footer-column logo-column">
        <div class="logo">
          <img src="/assets/caa-logo.png" alt="CAA Logo" />
          <span>CIVIL AVIATION AUTHOURITY</span>
        </div>

        <p class="description">
  Our system empowers aviation authorities to transform raw security data into clear, actionable insights — making air travel safer, smarter, and more secure across Zambia.
</p>

        <div class="social-icons">
          <a href="#"><i class="fab fa-x-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-linkedin-in"></i></a>
          <a href="#"><i class="fab fa-github"></i></a>
        </div>
      </div> -->

            <!-- Navigation Links -->
            <!-- <div class="footer-column">
        <h3>About</h3>
        <ul>
          <li><a href="#">About Us</a></li>
         
        </ul>
      </div> -->

            <!-- <div class="footer-column">
        <h3>Resources</h3>
        <ul>
          <li><a href="#">Documentation</a></li>
         
        </ul>
      </div> -->

            <!-- <div class="footer-column">
        <h3>Contact</h3>
        <ul>
          <li><a href="#">Contact Us</a></li>
         
        </ul>
      </div> -->
        </div>

        <!-- Bottom Footer -->
        <div class="footer-bottom">
            <p>© 2025 Zambia Civil Aviation Authority. All rights reserved.</p>
            <div class="footer-links">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Cookie Settings</a>
            </div>
        </div>
    </footer>
</template>

<script>
export default {
    name: 'AppFooter',
};
</script>

<style scoped>
.footer {
    background-color: #f3f4f6;
    /* Light gray */
    color: #4b5563;
    /* Gray text */
    border-top: 1px solid #e5e7eb;
    padding: 40px 20px;
    font-family: 'Poppins', 'Segoe UI', sans-serif; /* Updated font */
    /* font-family: sans-serif; */
}

.footer-container {
    display: flex;
    flex-wrap: wrap;
    max-width: 1200px;
    margin: 0 auto;
    gap: 40px;
}

.footer-column {
    flex: 1 1 200px;
    min-width: 180px;
}

.logo-column {
    flex: 2 1 300px;
}

.logo {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 16px;
}

.logo img {
    width: 20px;
    height: 20px;
    object-fit: contain;
}

.logo span {
    font-weight: bold;
    font-size: 1.1rem;
}

.description {
    font-size: 0.9rem;
    margin-bottom: 16px;
    color: #6b7280;
}

.social-icons a {
    margin-right: 12px;
    color: #6b7280;
    font-size: 18px;
    text-decoration: none;
}

.footer-column h3 {
    font-size: 0.95rem;
    font-weight: bold;
    margin-bottom: 12px;
}

.footer-column ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-column ul li {
    margin-bottom: 8px;
}

.footer-column ul li a {
    color: #4b5563;
    text-decoration: none;
    font-size: 0.9rem;
}

.footer-column ul li a:hover {
    text-decoration: underline;
}

.footer-bottom {
    border-top: 1px solid #e5e7eb;
    margin-top: 40px;
    padding-top: 20px;
    text-align: center;
    font-size: 0.85rem;
    color: #9ca3af;
}

.footer-links {
    margin-top: 8px;
}

.footer-links a {
    margin: 0 10px;
    color: #6b7280;
    text-decoration: none;
}

.footer-links a:hover {
    text-decoration: underline;
}

/* Responsive layout */
@media (max-width: 768px) {
    .footer-container {
        flex-direction: column;
        gap: 30px;
    }

    .footer-column {
        min-width: unset;
    }

    .footer-bottom {
        text-align: left;
    }

    .footer-links {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 6px;
    }
}
</style>
