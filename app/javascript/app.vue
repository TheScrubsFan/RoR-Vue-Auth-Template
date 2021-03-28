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
import LoginModal from './components/sign_in'
import Navigation from './components/navigation'

export default {
  components: {
    LoginModal,
    Navigation
  },
  data () {
    return {
      showModal: !this.$store.state.auth.status.loggedIn
    }
  },
  watch: {
    '$store.state.auth.status.loggedIn' () {
      this.showModal = !this.$store.state.auth.status.loggedIn
    }
  }
}
</script>
