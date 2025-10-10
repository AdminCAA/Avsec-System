<script setup> 
import { ref, watch } from 'vue';
import { Head, Link, useForm } from '@inertiajs/vue3';

defineProps({
  canResetPassword: { type: Boolean },
  status: { type: String },
});

const form = useForm({
  email: '',
  password: '',
  remember: false,
});

const submit = () => {
  form.post(route('login'), {
    onFinish: () => form.reset('password'),
  });
};

// Errors
const emailError = ref('');
const passwordError = ref('');

watch(() => form.email, (value) => {
  emailError.value = '';
  if (!value) emailError.value = 'Email is required.';
  else if (!/^\S+@\S+\.\S+$/.test(value)) emailError.value = 'Enter a valid email address.';
});

watch(() => form.password, (value) => {
  passwordError.value = '';
  if (!value) passwordError.value = 'Password is required.';
  else if (value.length < 6) passwordError.value = 'Password must be at least 6 characters.';
});
</script>

<template>
  <Head title="Login" />
  <div class="login-wrapper">
    <div class="login-container">
      <!-- LEFT SIDE -->
      <div class="left-panel">
        <!-- Centered Header Section -->
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Welcome to</h2>
          <h2 class="welcome-title">Aviation Security Information System</h2>
          <p class="subtitle">Enter email & password to login</p>
        </div>

        <form @submit.prevent="submit" class="login-form">
          <input v-model="form.email" type="email" placeholder="Email" class="input-field" />
          <div v-if="emailError" class="error">{{ emailError }}</div>

          <input v-model="form.password" type="password" placeholder="Password" class="input-field" />
          <div v-if="passwordError" class="error">{{ passwordError }}</div>

          <!-- Remember Me + Forgot Password Row -->
          <div class="remember-forgot-row">
            <label class="remember-label">
              <input
                type="checkbox"
                v-model="form.remember"
                class="remember-checkbox"
              />
              Remember Me
            </label>

            <Link
              v-if="canResetPassword"
              :href="route('password.request')"
              class="forgot-link"
            >
              Forgot your password?
            </Link>
          </div>

          <button type="submit" class="btn-primary" :disabled="form.processing">
            <span v-if="form.processing"><i class="fas fa-spinner fa-spin"></i> Wait..</span>
            <span v-else>Sign in</span>
          </button>
        </form>

        <p class="account-text">
          Not yet registered?
          <Link :href="route('register')">Register</Link>
        </p>

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

      <!-- RIGHT SIDE -->
      <div class="right-panel">
        <h2>Aviation <br/> Security Information Management System (ASIMS).</h2>
        <img src="/assets/register-2.jpg" class="illustration" alt="Aviation Security" />

        <!-- Register Info -->
        <div class="register-info">
          <h3>New Here?</h3>
          <p>
            Register an account to access ASIMS. Once registered, you can securely log in,
            manage your profile, and gain access to Aviation Security Information.
          </p>
          <Link :href="route('register')" class="btn-register">Register Now</Link>
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

/* Remember + Forgot row */
.remember-forgot-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.remember-label {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  color: #333;
}

.remember-checkbox {
  width: 16px;
  height: 16px;
  cursor: pointer;
}

.forgot-link {
  font-size: 13px;
  color: #005fa3;
  text-decoration: underline;
  transition: 0.2s;
}

.forgot-link:hover {
  color: #003e6b;
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

.right-panel h2 {
  position: absolute;
  top: 40px;
  z-index: 2;
  color: #fff;
  text-align: center;
  padding: 20px;
  font-size: 28px;
  width: 80%;
  margin: auto;
  line-height: 1.4;
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
