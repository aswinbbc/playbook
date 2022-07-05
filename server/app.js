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
  console.log(`connected! ${socket.id}`);

  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    try {
      const roomId = randomInt(100).toString();
      console.log(roomId);
      socket.join(roomId);
      let data = {
        roomId,
        nickname,
      };
      io.to(roomId).emit("createRoomSuccess", data);
    } catch (e) {
      console.log(e);
    }
  });
  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      console.log(`new connection : ${socket.id}`);
      socket.join(roomId);
      let data = {
        roomId,
        nickname,
      };
      io.to(roomId).emit("createRoomSuccess", data);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("send_message", async ({ message, user, roomId }) => {
    console.log(message);
    console.log(user);
    try {
      let data = { message, user };
      io.to(roomId).emit("new_message", data);
    } catch (e) {
      console.log(e);
    }
  });
});

server.listen(port, "0.0.0.0", () => {
  console.log(`Server started and running on port ${port}`);
});
