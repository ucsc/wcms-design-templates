var Hapi = require('hapi');

var server = new Hapi.Server(8000, "localhost");

server.route({
  path: "/{path*}",
  method: "GET",
  handler: {
    directory: {
      path: "./app/build/",
      listing: true,
      index: true
    }
  }
});

server.start(function() {
  console.log("Hapi server started @ " + server.info.uri);
});
