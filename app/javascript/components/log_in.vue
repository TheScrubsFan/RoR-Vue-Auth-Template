<template>

  <v-dialog v-model="dialog" persistent max-width="600px" min-width="360px">
    <div>
      <v-tabs v-model="tab" show-arrows background-color="orange accent-4" icons-and-text dark grow>
        <v-tabs-slider color="purple darken-4"></v-tabs-slider>
        <v-tab>
          <v-icon large>mdi-account</v-icon>
          <div class="caption py-1">Войти</div>
        </v-tab>
        <v-tab>
          <v-icon large>mdi-account-outline</v-icon>
          <div class="caption py-1">Зарегистрироваться</div>
        </v-tab>

        <v-tab-item>
          <v-card class="px-4">
            <v-card-text>
              <v-form ref="loginForm" v-model="valid" lazy-validation>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      v-model="loginEmail"
                      :rules="[rules.required, rules.emailFormat]"
                      label="E-mail"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="loginPassword"
                      :rules="[rules.required, rules.min]"
                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="showPassword ? 'text' : 'password'"
                      name="input-10-1"
                      label="Password"
                      hint="At least 8 characters"
                      counter
                      @click:append="showPassword = !showPassword">
                    </v-text-field>
                  </v-col>
                  <v-col class="d-flex" cols="12" sm="6" xsm="12"></v-col>
                  <v-spacer></v-spacer>
                  <v-col class="d-flex" cols="12" sm="3" xsm="12" align-end>
                    <v-btn x-large block :disabled="!valid" color="success" @click="login"> Login </v-btn>
                  </v-col>
                </v-row>
              </v-form>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <v-tab-item>
          <v-card class="px-4">
            <v-card-text>
              <v-form ref="registerForm" v-model="valid" lazy-validation>
                <v-row>
                  <v-col cols="12">
                    <v-text-field
                      v-model="name"
                      :rules="[rules.required]"
                      label="Name"
                      maxlength="20"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="email"
                      :rules="[rules.required, rules.emailFormat]"
                      label="E-mail"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="password"
                      :rules="[rules.required, rules.min]"
                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="showPassword ? 'text' : 'password'"
                      name="input-10-1"
                      label="Password"
                      hint="At least 8 characters"
                      counter
                      @click:append="showPassword = !showPassword">
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field block
                      v-model="verify"
                      :rules="[rules.required, rules.min, passwordMatch]"
                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="showPassword ? 'text' : 'password'"
                      name="input-10-1"
                      label="Confirm Password"
                      counter
                      @click:append="showPassword = !showPassword">
                    </v-text-field>
                  </v-col>
                  <v-spacer></v-spacer>
                  <v-col class="d-flex ml-auto" cols="12" sm="3" xsm="12">
                    <v-btn x-large block :disabled="!valid" color="success" @click="register">Register</v-btn>
                  </v-col>
                </v-row>
              </v-form>
            </v-card-text>
          </v-card>
        </v-tab-item>

      </v-tabs>
    </div>
  </v-dialog>

</template>

<script>
import axios from 'axios'

export default {
  computed: {
    passwordMatch() {
      return () => this.password === this.verify || "Password must match";
    },
  },
  methods: {
    login() {
      if (this.$refs.loginForm.validate()) {
        let params = {
          email: this.loginEmail,
          password: this.loginPassword
        }
        let url = '/api/token/create'

        axios
          .post(url, params)
          .then(response => (console.log(response)))
      }
    },
    register() {
      if (this.$refs.registerForm.validate()) {
        let params = {
          name: this.name,
          email: this.email,
          password: this.password,
          password_confimation: this.verify
        }
        let url = '/api/registration'

        axios
          .post(url, params)
          .then(response => (console.log(response)))
      }
    }
  },
  data: () => ({
    dialog: true,
    tab: 0,
    valid: true,
    showPassword: false,
    name: "",
    email: "",
    password: "",
    verify: "",
    loginPassword: "",
    loginEmail: "",
    rules: {
      required: value => !!value || "Required.",
      min: v => (v && v.length >= 8) || "Min 8 characters",
      emailFormat: v => /.+@.+\..+/.test(v) || "E-mail must be valid"
    }
  })
}
</script>
