<script setup>
import { computed } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

const props = defineProps({
  status: { type: String },
});

const form = useForm({});

const submit = () => {
  form.post(route('verification.send'));
};

const verificationLinkSent = computed(() => props.status === 'verification-link-sent');
</script>

<template>
  <Head title="Email Verification" />

  <div class="login-wrapper">
    <div class="login-container">

      <!-- LEFT PANEL -->
      <div class="left-panel">
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Email Verification</h2>
          <p class="subtitle">
            Thanks for signing up! Before getting started, please verify your email address by clicking the link we emailed you.
          </p>
        </div>

        <!-- Success message -->
        <div v-if="verificationLinkSent" class="success-message">
          A new verification link has been sent to the email address you provided during registration.
        </div>

        <form @submit.prevent="submit" class="login-form">
          <button type="submit" class="btn-primary" :disabled="form.processing">
            <span v-if="form.processing">
              <i class="fas fa-spinner fa-spin"></i> Sending...
            </span>
            <span v-else>Resend Verification Email</span>
          </button>
        </form>

        <!-- <p class="account-text">
          <Link :href="route('logout')" method="post" as="button" class="btn-logout">
            Log Out
          </Link>
        </p> -->

        <!-- <div class="bottom-row">
          <div class="avatars">
            <img src="/assets/user1.jpg" alt="user1" />
            <img src="/assets/user2.jpg" alt="user2" />
            <img src="/assets/user3.jpg" alt="user3" />
            <span>Join with 20k+ Users!</span>
          </div>
          <button class="arrow-btn">➜</button>
        </div> -->
      </div>

      <!-- RIGHT PANEL -->
      <div class="right-panel">
        <h2>Aviation <br/> Security Information Management System (ASIMS).</h2>
        <img src="/assets/register-2.jpg" class="illustration" alt="Email Verification" />

        <div class="register-info">
          <h3>Need Help?</h3>
          <p>
            If you didn’t receive the verification email, click the button to resend it.
            Make sure to check your spam folder as well.
          </p>
             <Link :href="route('logout')" method="post" as="button" class="btn-register">Log Out</Link>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
/* Wrapper */
body,
html {
  height: 100%;
  margin: 0;
}

.login-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  background: #f0f2f5;
  padding: 40px;
}

/* Container */
.login-container {
  display: flex;
  width: 80%;
  min-height: 70vh;
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  font-family: 'Poppins', 'Segoe UI', sans-serif;
  /* font-family: 'Inter', sans-serif; */
}

/* LEFT PANEL */
.left-panel {
  flex: 1;
  background: #fff;
  padding: 40px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.header-section {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 20px;
}

.caa-logo {
  width: 120px;
  height: auto;
  margin-bottom: 15px;
}

.welcome-title {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 10px;
  text-align: center;
}

.subtitle {
  font-size: 14px;
  color: #666;
  max-width: 310px;
  text-align: center;
}

.login-form {
  display: flex;
  flex-direction: column;
}

.input-field {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 12px;
  margin-bottom: 15px;
}

.error {
  font-size: 13px;
  color: red;
  margin-bottom: 10px;
}

.btn-primary {
  background: #000;
  color: #fff;
  padding: 12px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
}

.account-text {
  margin-top: 20px;
  text-align: center;
}

.bottom-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.avatars img {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  margin-right: -10px;
}

.arrow-btn {
  background: #000;
  color: #fff;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  font-size: 20px;
  cursor: pointer;
}

/* RIGHT PANEL */
.right-panel {
  flex: 1;
  background: #e9f5f9;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  position: relative;
}

.right-panel h2,
.right-panel .cta {
  position: absolute;
  z-index: 2;
  color: #fff;
  text-align: center;
  padding: 20px;
}

.right-panel h2 {
  top: 40px;
  font-size: 28px;
  margin-bottom: 20px;
  width: 80%;          /* takes 80% of right panel width */
  margin-left: auto;
  margin-right: auto;
  line-height: 1.4;
}

.right-panel .cta {
  bottom: 150px;
  left: 50%;
  transform: translateX(-50%);
  max-width: 80%;
}

.illustration {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Register Info */
.register-info {
  position: absolute;
  bottom: 40px;
  background: rgba(255,255,255,0.9);
  padding: 20px;
  border-radius: 12px;
  text-align: center;
  max-width: 80%;
}

.register-info h3 {
  margin-bottom: 10px;
  color: #333;
}

.register-info p {
  font-size: 14px;
  color: #555;
  margin-bottom: 15px;
}

.btn-register {
  display: inline-block;
  background-color: #000;
  color: white;
  padding: 10px 20px;
  border-radius: 8px;
  text-decoration: none;
  transition: 0.3s;
}

.btn-register:hover {
  background-color: #005fa3;
}

/* Responsive */
@media (max-width: 900px) {
  .login-container {
    flex-direction: column;
    width: 95%;
    height: auto;
  }

  .left-panel,
  .right-panel {
    flex: none;
    width: 100%;
    min-height: auto;
    padding: 20px;
  }

  .right-panel h2,
  .right-panel .cta,
  .register-info {
    position: static;
    transform: none;
    margin-top: 20px;
  }

  .illustration {
    height: 250px;
  }
}
</style>
