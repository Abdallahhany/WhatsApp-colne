const express = require('express');
const https = require('https');
const cors = require('cors');
const app = express();
const fs = require('fs');
const port = process.env.PORT || 8080;


const key = fs.readFileSync('server.key');
const cert = fs.readFileSync('server.cert');


var server = https.createServer({key:key,cert:cert},app);

var io = require('socket.io')(server);
var clients ={};
app.use(express.json());
io.on('connection',(socket)=>{
    console.log('socket connected');
    console.log(socket.id , "has Joined");
    socket.on('signin',(id)=>{
        console.log(id);
        clients[id] = socket;
        console.log(clients);
    });
    socket.on("message",(msg)=>{
        console.log(msg);
        let destinationId = msg.destinationId;
        console.log(destinationId);
        if(clients[destinationId])
            clients[destinationId].emit("message",msg);
    })
});

server.listen(port,"0.0.0.0",()=>{
    console.log('Connected to port ' + port)

});