<template>
  <v-navigation-drawer
    v-model="drawer"
    :mini-variant.sync="mini"
    hide-overlay
    stateless
    app>

    <v-layout column fill-height>
      <v-list dense>
        <v-list-item link @click.stop="mini = !mini">
          <v-list-item-icon>
            <v-icon>mdi-menu</v-icon>
          </v-list-item-icon>

          <v-list-item-content></v-list-item-content>
        </v-list-item>
      </v-list>

      <v-spacer></v-spacer>

      <v-list nav dense>
        <v-list-item link class='orange' @click='signOut'>
          <v-list-item-icon>
            <v-icon>mdi-exit-to-app</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title>Выход</v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-layout>

  </v-navigation-drawer>
</template>

<script>
export default {
  methods: {
    signOut () {
      this.$store.dispatch('auth/logout').then(
        () => {
          this.$toast.warning('Вы вышли из аккаунта!', {duration: 7000})
        },
        error => {
          this.$toast.error(error, {duration: 7000})
          console.log(error)
        }
      )
    }
  },

  data () {
    return {
      drawer: true,
      mini: true
    }
  }
}
</script>
