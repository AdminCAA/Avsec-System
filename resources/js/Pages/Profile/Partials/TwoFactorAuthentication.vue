
<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { Link, useForm, usePage } from '@inertiajs/vue3';
import DangerButton from '@/Components/DangerButton.vue';
import { ref,onMounted } from 'vue';


defineProps({
    mustVerifyEmail: {
        type: Boolean,
    },
    status: {
        type: String,
    },
});

const user = ref(usePage().props.auth.user);
const qrCodeSvg = ref('');
const recoveryCodes = ref([]);
const form = useForm();

const toggleTwoFactor = () => {
  if (user.value.two_factor_enabled) {
    form.delete(route('two-factor.disable'), {
      onSuccess: (page) => {        
        user.value = page.props.auth.user;  
        qrCodeSvg.value = '';    
                 
      },
    });
  } else {
    form.post(route('two-factor.enable'), {
      onSuccess: (page) => {
        user.value = page.props.auth.user;   
        fetchQrCode();    
        fetchRecoveryCodes();        
      },
    });
  }
};

onMounted(() => {    
    if(user.value.two_factor_enabled) {           
        fetchQrCode();
        fetchRecoveryCodes();
    }
    else {
        qrCodeSvg.value = '';
    }    
});

const regerateRecoveryCodes = () => {
    form.post(route('two-factor.recovery-codes'), {
        onSuccess: (page) => {
            user.value = page.props.auth.user;   
            fetchRecoveryCodes();
        },
    });
};


const fetchQrCode = async () => {
    axios.get(route('two-factor.qr-code')).then(response => {
        qrCodeSvg.value = response.data.svg;
    });
};

const fetchRecoveryCodes = async () => {
    axios.get(route('two-factor.recovery-codes')).then(response => {        
        recoveryCodes.value = response.data;
    });
};
</script>

<template>
    <section>
        <div class="card card-info mt-5">
            <div class="card-header">
                <h3 class="card-title">Two Factor Authentication</h3>
            </div>
            <div class="card-body">
                <header class="mb-3">
                    <h2 class="h5 fw-medium text-dark mb-1">
                        2 Factor Authentication
                    </h2>
                    <p class="small text-muted mb-0">
                        Add additional security to your account using two factor authentication.
                    </p>
                </header>

                <div class="row my-4 align-items-start">
                    <!-- Left Column: QR -->
                    <div class="col-md-6">
                        <form @submit.prevent="toggleTwoFactor" class="mt-4">
                            <div class="d-flex flex-column gap-3">
                                <!-- Enable Button -->
                                <div v-if="!user.two_factor_enabled">
                                    <button :disabled="form.processing" class="btn btn-info w-100"
                                    :class="{ 'opacity-25': form.processing }"    
                                    >
                                    <span v-if="form.processing">
                                        <i class="fas fa-spinner fa-spin"></i> Enabling...
                                    </span>
                                    <span v-else>                                        
                                        <i class="fas fa-shield"></i>Enable Two Factor Authentication
                                    </span>
                                    </button>

                                </div>

                                <!-- QR Code Display -->
                                <div v-else class="d-flex flex-column align-items-center text-center gap-2">
                                    <h6 v-if="qrCodeSvg" class="fw-semibold mb-3">
                                        Scan this QR code:   
                                                                            
                                    </h6>
                                    <div
                                        v-html="qrCodeSvg"
                                        role="img"
                                        aria-label="QR code for two-factor authentication"
                                        class="d-inline-block"
                                    ></div>
                                

                                    <!-- Disable Button -->
                                    <button :disabled="form.processing" class="btn btn-danger w-100 mt-4"
                                        :class="{ 'opacity-25': form.processing }"
                                    >
                                    <span v-if="form.processing">
                                        <i class="fas fa-spinner fa-spin"></i> Disabling...
                                    </span>
                                    <span v-else>
                                        Disable Two Factor Authentication
                                    </span>
                                    </button>

                                    <!-- Status Messages -->
                                    <Transition enter-active-class="fade show" leave-active-class="fade">
                                        <div
                                            v-if="!user.two_factor_enabled && form.recentlySuccessful"
                                            class="alert alert-info small mt-3"
                                            role="alert"
                                        >
                                            Two-factor authentication is enabled. Scan the QR code and save the recovery codes.
                                        </div>
                                        <div
                                            v-else-if="user.two_factor_enabled && form.recentlySuccessful"
                                            class="alert alert-warning small mt-3"
                                            role="alert"
                                        >
                                            Two-factor authentication is disabled.
                                        </div>
                                    </Transition>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Right Column: Recovery Codes -->
                    <div class="col-md-6" v-if="user.two_factor_enabled">
                        <form @submit.prevent="regerateRecoveryCodes" class="mt-4">
                            <div class="text-center">
                                <h6 v-if="qrCodeSvg" class="fw-semibold mb-3">Recovery Codes:</h6>
                                <div class="row g-2 justify-content-center">
                                    <div 
                                        v-for="code in recoveryCodes" 
                                        :key="code" 
                                        class="col-6"
                                    >
                                        <code class="w-100 d-block px-3 py-2 my-1 bg-light border rounded">
                                            {{ code }}
                                        </code>
                                    </div>
                                </div>
                            </div>

                            <div v-if="qrCodeSvg" class="d-flex flex-column gap-3" style="margin-top: 30px;">
                                <button :disabled="form.processing" class="btn btn-info w-100"
                                    :class="{ 'opacity-25': form.processing }"
                                >
                                <span v-if="form.processing">
                                    <i class="fas fa-spinner fa-spin"></i> Generating Codes...
                                </span>
                                <span v-else>
                                    Regenerate Recovery Codes
                                </span>  
                                    
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
</template>

