const db = require("../db");

class UserController {
  async setUser(req, res) {
    const { login, password, email } = req.body;
    const newPerson = await db.query(
      "INSERT INTO users (login, password, email) values ($1, $2, $3) RETURNING *",
      [login, password, email]
    );
    res.json(newPerson.rows[0]);
  }
  async getUser(req, res) {
    const users = await db.query("SELECT * FROM users");
    res.json(users.rows);
  }
  async getOneUser(req, res) {
    const id = req.body;
    const users = await db.query(
      "SELECT * FROM users where id = $1 retrning *",
      [id]
    );
    console.log(users);
    res.json(users.rows);
  }
  async updateUser(req, res) {
    const { login, password, email, id } = req.body;
    const newPerson = await db.query(
      "UPDATE users set login = $1, password = $2, email = $3 where id = $4 RETURNING last_post_id",
      [login, password, email, id]
    );
  }
  async deleteUser(req, res) {}
}

module.exports = new UserController();
