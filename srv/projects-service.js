const WebSocketServer = require('ws').Server;
const ws = new WebSocketServer({
    port: process.env.PORT || 8080
});

module.exports = async (srv) => {
    srv.after('CREATE', '*', async (ideas, req) => {
        for (const client of ws.clients) {
            client.send(JSON.stringify(ideas));
        }
    });
}