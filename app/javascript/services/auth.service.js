import axios from 'axios';

class AuthService {
  login(user) {
    let url = '/api/tokens/create'

    return axios
      .post(url, user)
      .then(
        response => {
          if (response.data.access_token) {
            localStorage.setItem('user', JSON.stringify(response.data));
          }

          return response.data
        }
      )
  }

  logout() {
    localStorage.removeItem('user');
  }

  //register(user) {
  //return axios.post('/', {
      //username: user.username,
      //email: user.email,
      //password: user.password
    //});
  //}
}

export default new AuthService();
