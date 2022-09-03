const { randomInt } = require("crypto");
const express = require("express");
const http = require("http");
const User = require("./models/user");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);

var io = require("socket.io")(server);

var allClients = [];
// middle ware
app.use(express.json());

io.on("connection", (socket) => {
  console.log(`connected! ${socket.id}`);

  socket.on("createRoom", async ({ nickname }) => {
    console.log(nickname);
    allClients.push(new User(nickname, socket.id));
    // allClients.push(socket);
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
  socket.on("disconnect", function () {
    console.log("Got disconnect!");

    // var i = allClients.indexOf(socket);
    // allClients.splice(i, 1);
    // console.log(allClients);
  });

  socket.on("joinRoom", async ({ nickname, roomId }) => {
    try {
      allClients.push(new User(nickname, socket.id));
      console.log(allClients);
      // allClients.push(socket);
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

  socket.on("change_area", async ({ user, roomId }) => {
    try {
      let data = { roomId, user };
      io.to(roomId).emit("area_changed", data);
    } catch (e) {
      console.log(e);
    }
  });

  socket.on("send_message", async ({ message, user, roomId }) => {
    console.log(message);
    console.log(user);
    var i = allClients.indexOf((x) => x.id === socket.id);
    console.log(i);
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
