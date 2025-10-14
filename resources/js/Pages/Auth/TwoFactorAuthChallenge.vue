<script setup>
import { Head, useForm, Link, usePage } from '@inertiajs/vue3';
import { ref } from 'vue';

const form = useForm({
  code: '',
  recovery_code: '',
});

const recovery = ref(usePage().props.recovery || false);

const submit = () => {
  form.post(route('two-factor.login'), {
    onFinish: () => form.reset(),
  });
};
</script>

<template>
  <Head title="Two-Factor Authentication" />

  <div class="login-wrapper">
    <div class="login-container">
      <!-- LEFT PANEL -->
      <div class="left-panel">
        <div class="header-section">
          <img src="/assets/caa-logo.png" alt="CAA Logo" class="caa-logo" />
          <h2 class="welcome-title">Two-Factor Authentication</h2>

          <p class="subtitle" v-if="!recovery">
            Please confirm access to your account by entering the authentication code provided by your authenticator app.
          </p>
          <p class="subtitle" v-else>
            Please confirm access to your account by entering one of your recovery codes provided during setup.
          </p>
        </div>

        <form @submit.prevent="submit" class="login-form">
          <div v-if="!recovery">
            <input
              id="code"
              type="password"
              inputmode="numeric"
              v-model="form.code"
              autocomplete="one-time-code"
              placeholder="Enter your 2FA code"
              class="input-field"
              :class="{ 'is-invalid': form.errors.code }"
              autofocus
              style="width: 100%"
            />
            <div v-if="form.errors.code" class="error">{{ form.errors.code }}</div>
          </div>

          <div v-else>
            <input
              id="recovery_code"
              type="password"
              v-model="form.recovery_code"
              autocomplete="one-time-code"
              placeholder="Enter your recovery code"
              class="input-field"
              :class="{ 'is-invalid': form.errors.recovery_code }"
              autofocus
            />
            <div v-if="form.errors.recovery_code" class="error">{{ form.errors.recovery_code }}</div>
          </div>

          <div class="link-row">
            <Link
              v-if="!recovery"
              :href="route('two-factor.login', { recovery: true })"
              class="switch-link"
            >
              Use Recovery Code
            </Link>
            <Link
              v-else
              :href="route('two-factor.login')"
              class="switch-link"
            >
              Use Authentication Code
            </Link>
          </div>

          <button type="submit" class="btn-primary" :disabled="form.processing">
            <span v-if="form.processing">
              <i class="fas fa-spinner fa-spin"></i> Verifying...
            </span>
            <span v-else>Verify & Login</span>
          </button>
        </form>

        <p class="account-text">
          <Link :href="route('logout')" method="post" as="button" class="btn-logout">
            Log Out
          </Link>
        </p>
      </div>

      <!-- RIGHT PANEL -->
      <div class="right-panel">
        <h2>Aviation <br />Security Information Management System (ASIMS).</h2>
        <img src="/assets/register-2.jpg" class="illustration" alt="2FA Verification" />

        <div class="register-info">
          <h3>Having Trouble?</h3>
          <p>
            If you’ve lost access to your authenticator app, you can log in using one of your recovery codes.
          </p>
          <Link :href="route('logout')" method="post" as="button" class="btn-register">
            Log Out
          </Link>
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

.btn-primary {
  background: #000;
  color: #fff;
  padding: 12px;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.3s ease;
}

.btn-primary:hover {
  background-color: #005fa3;
}

.account-text {
  margin-top: 20px;
  text-align: center;
}

.btn-logout {
  background: transparent;
  border: none;
  color: #555;
  font-size: 14px;
  cursor: pointer;
  text-decoration: underline;
}

.switch-link {
  font-size: 13px;
  color: #007bff;
  text-decoration: underline;
  margin-bottom: 10px;
}

.link-row {
  margin-bottom: 10px;
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
  font-size: 28px;
  color: #fff;
  width: 80%;
  text-align: center;
  line-height: 1.4;
  z-index: 2;
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
  background: rgba(255, 255, 255, 0.5); /* reduced opacity */
  padding: 20px;
  border-radius: 12px;
  text-align: center;
  max-width: 80%;
  backdrop-filter: blur(2px); 
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





<!-- <script setup>
import GuestLayout from '@/Layouts/GuestLayout.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Head, useForm,Link, usePage } from '@inertiajs/vue3';
import { ref } from 'vue';



const form = useForm({
    code: '',
    recovery_code: '',
});


const recovery = ref(usePage().props.recovery || false);

const submit = () => {
    form.post(route('two-factor.login'), {
        onFinish: () => form.reset(),
    });
};
</script>

<template>
    <GuestLayout>
        <Head title="Two Factor Challenge" />

        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Two Factor Challenge</h3>
            </div>
            <div class="card-body">

                <div v-if="!recovery" class="mb-4 text-secondary">
                    Please confirm access to your account by entering the authentication code provided by your authenticator app.
                </div>
                <div v-else class="mb-4 text-secondary">
                    Please confirm access to your account by entering one of your recovery codes provided by 2FA.
                </div>

                <form @submit.prevent="submit">
                    <div v-if="!recovery" class="mb-3">
                        <div class="mb-3">
                        <label for="code" class="form-label">Code</label>
                        <input
                            id="code"
                            type="password"
                            inputmode="numeric"
                            class="form-control"
                            v-model="form.code"                            
                            autocomplete="one-time-code"
                            placeholder="Enter your two-factor authentication code"
                            autofocus
                            :class="{ 'is-invalid': form.errors.code }"
                        />
                        <div v-if="form.errors.code" class="invalid-feedback">
                            {{ form.errors.code }}
                        </div>
                        </div>
                    </div>
                    <div v-else>
                        <div class="mb-3">
                        <label for="recovery_code" class="form-label">Recovery Code</label>
                        <input
                            id="recovery_code"
                            type="password"                            
                            class="form-control"
                            v-model="form.recovery_code"                            
                            autocomplete="one-time-code"
                            placeholder="Enter your recovery code"
                            autofocus
                            :class="{ 'is-invalid': form.errors.recovery_code }"
                        />
                        <div v-if="form.errors.recovery_code" class="invalid-feedback">
                            {{ form.errors.recovery_code }}
                        </div>
                        </div>
                    </div>

                    <div class="justify-content-start">
                        <Link  v-if="!recovery"                               
                                :href="route('two-factor.login', {'recovery': true})"
                                class="mb-1 rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                            >
                                Use Recovery Code
                        </Link>
                        <Link v-else
                                :href="route('two-factor.login')"
                                class="mb-1 rounded-md text-sm text-gray-600 underline hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                            >
                                Use Authentication Code
                        </Link>
                    </div>

                    <div class="d-flex justify-content-end">                                                                      
                        <button
                            type="submit"
                            class="btn btn-info ms-3"
                            :class="{ 'disabled opacity-50': form.processing }"
                            :disabled="form.processing"
                        >
                            <span v-if="form.processing">
                                <i class="fas fa-spinner fa-spin"></i> Wait..
                            </span>
                            <span v-else>
                                Login
                            </span>                            
                        </button>
                    </div>
                </form>

            </div>
        </div>
    </GuestLayout>
</template>
 -->
