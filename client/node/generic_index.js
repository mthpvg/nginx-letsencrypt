// From https://expressjs.com/en/starter/hello-world.html

const express = require('express');
const app = express();
const path = require('path');

app.use(
  express.static(path.join(__dirname, 'public'), { maxAge: 31557600000 })
);

app.get('/', function (req, res) {
  res.send('Hello World!')
});

app.listen(<PORT>, function () {
  console.log('Example app listening on port <PORT>!')
});
