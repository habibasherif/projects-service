const stompClient = new StompJs.Client({
    brokerURL: 'wss://authenticated:@projects-service-triumphant-baboon-hl.cfapps.us10-001.hana.ondemand.com/gs-guide-websocket',
    connectHeaders: {
        login: 'authenticated',
        passcode:''
    }
});

stompClient.onConnect = (frame) => {
    console.log('Inside Connect');
    setConnected(true);
    console.log('Connected: ' + frame);
    stompClient.subscribe('/topic/greetings', (greeting) => {
        showGreeting(JSON.parse(greeting.body).content);
    });
};

stompClient.onWebSocketError = (error) => {
    console.error('Error with websocket', error);
};

stompClient.onStompError = (frame) => {
    console.error('Broker reported error: ' + frame.headers['message']);
    console.error('Additional details: ' + frame.body);
};

function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("#greetings").html("");
}

function connect() {
    console.log('Inside Connect');
    console.log(stompClient);
    stompClient.activate();
}

function disconnect() {
    stompClient.deactivate();
    setConnected(false);
    console.log("Disconnected");
}

// function sendName() {
//     console.log($("#numberInput").val());
//     stompClient.publish({
//         destination: "/app/hello",
        
//         body: parseInt($("#numberInput").val())
//     });
//     console.log("Inside send name")
// }

function sendName() {
    
    
    const context ={
        eventId: 123,
        eventName: 'Create',
        entries: $("#jsonInput").val()
      };
    console.log($("#jsonInput").val());
    stompClient.publish({
        destination: "/app/hello",
        
        body: $("#jsonInput").val()
        //JSON.stringify($("#jsonInput").val())
    });
    console.log("Inside send name")
}



function showGreeting(message) {
    console.log('Inside greeting')
    $("#greetings").append("<tr><td>" + message + "</td></tr>");
}

$(function () {
    $("form").on('submit', (e) => e.preventDefault());
    $( "#connect" ).click(() => connect());
    $( "#disconnect" ).click(() => disconnect());
    $( "#send" ).click(() => sendName());
});