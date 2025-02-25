<template>
  <v-dialog v-model="showDialog" persistent max-width="600px" min-width="360px">
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
                      v-model="user.email"
                      :rules="[rules.required, rules.emailFormat]"
                      label="Адрес электронной почты"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="user.password"
                      :rules="[rules.required, rules.min]"
                      :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                      :type="showPassword ? 'text' : 'password'"
                      name="input-10-1"
                      label="Пароль"
                      hint="At least 8 characters"
                      counter
                      @click:append="showPassword = !showPassword">
                    </v-text-field>
                  </v-col>
                  <v-col class="d-flex" cols="12" sm="6" xsm="12"></v-col>
                  <v-spacer></v-spacer>
                  <v-col class="d-flex" cols="12" sm="3" xsm="12" align-end>
                    <v-btn x-large block :disabled="!valid" color="success" @click="login">
                      Войти
                    </v-btn>
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
                      v-model="user.name"
                      :rules="[rules.required]"
                      label="Name"
                      maxlength="20"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="user.email"
                      :rules="[rules.required, rules.emailFormat]"
                      label="E-mail"
                      required>
                    </v-text-field>
                  </v-col>
                  <v-col cols="12">
                    <v-text-field
                      v-model="user.password"
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
                      v-model="user.passwordConfirmation"
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
import User from '../models/user'

export default {
  props: {
     value: Boolean
  },
  computed: {
    passwordMatch() {
      return () => this.password === this.passwordConfirmation || "Password must match";
    },

    showDialog: {
      get () { return this.value },
      set (value) { this.$emit('input', value) }
    }
  },

  methods: {
    login() {
      if (this.$refs.loginForm.validate()) {
        this.$store.dispatch('auth/login', this.user).then(
          () => {
            this.$vToastify.success({
              body: 'Успешный вход!',
              defaultTitle: false
            })
            this.showDialog = false
          },
          error => {
            this.$vToastify.error({
              body: error,
              title: 'Ошибка!'
            })
            console.log(error)
          }
        )
      }
    },

    register() {
      if (this.$refs.registerForm.validate()) {
        this.$store.dispatch('auth/register', this.user).then(
          () => {
            this.$vToastify.success({
              body: 'Успешная регистрация!',
              defaultTitle: false
            })
            this.showDialog = false
          },
          error => {
            this.$vToastify.error({
              body: error,
              title: 'Ошибка!'
            })
            console.log(error)
          }
        )
      }
    }
  },

  data: () => ({
    user: new User({}),
    tab: 0,
    valid: true,
    showPassword: false,
    rules: {
      required: value => !!value || "Required.",
      min: v => (v && v.length >= 8) || "Min 8 characters",
      emailFormat: v => /.+@.+\..+/.test(v) || "E-mail must be valid"
    }
  })
}
</script>
