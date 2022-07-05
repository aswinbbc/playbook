const { randomInt } = require("crypto");
const express = require("express");
const http = require("http");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

// middle ware
app.use(express.json());

io.on("connection", (socket) => {
  console.log("connected!");
});

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});
