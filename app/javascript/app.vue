<template>
  <div id="app">
    <v-app>
      <navigation></navigation>

      <v-main>
        <v-layout>
          Add your components HERE
        </v-layout>
      </v-main>

      <router-view></router-view>

      <login-modal v-model='showModal'></login-modal>
    </v-app>
  </div>
</template>

<script>
import axios from 'axios'
import Interceptors from './services/interceptors.service'
import LoginModal from './components/sign_in'
import Navigation from './components/navigation'

export default {
  components: {
    LoginModal,
    Navigation
  },
  created() {
    Interceptors.transformKeys()
    Interceptors.setRefresh()

    this.$store.dispatch('auth/refresh')
      .then(
        () => {
          const user = this.$store.getters['auth/user']

          Interceptors.setTokens(user)
          axios.post('api/tokens/ola', {olaOla: 'viola'})
        },
        error => {
          this.$vToastify.error({
            body: error,
            title: 'Ошибка!'
          })
          console.log(error)
        }
      )
  },
  data () {
    return {
      showModal: null
    }
  },
  methods: {
    setShowModal() {
      if (this.$store.state.auth.loggedIn != null)
        this.showModal = !this.$store.state.auth.loggedIn
    }
  },
  mounted () {
    this.setShowModal()
  },
  watch: {
    '$store.state.auth.loggedIn' () {
      this.setShowModal()
    }
  }
}
</script>
