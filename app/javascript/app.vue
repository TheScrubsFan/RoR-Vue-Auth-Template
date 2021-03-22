<template>
  <div id="app">
    <router-link to="/sign_in">Войти</router-link>
    <router-link to="/sign_up">Зарегистрироваться</router-link>

    <router-view></router-view>
  </div>
</template>

<script>
export default {}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
