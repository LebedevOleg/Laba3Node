const express = require("express");
const config = require("config");
const userRouter = require("./routes/user.routes");
const signRouter = require("./routes/sign.routes");
const forumRouter = require("./routes/forum.routes");

const PORT = config.get("port") || 5000;

const app = express();
app.use(express.json({ extended: true }));
app.use("/api", signRouter);
app.use("/api/forum", forumRouter);
app.use("/api/data", userRouter);

app.listen(PORT, () =>
  console.log(`FUck has been started!!!!!! on port ${PORT}`)
);
