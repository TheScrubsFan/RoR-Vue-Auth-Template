export default class User {
  constructor(params) {
    this.id = params.id
    this.name = params.name
    this.email = params.email
    this.password = params.password
    this.password_confirmation = params.password_confirmation
  }
}
