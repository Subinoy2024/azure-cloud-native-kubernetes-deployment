const http = require('http');
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello from AKS!\n');
});
server.listen(80, () => {
  console.log('App running on port 80');
});