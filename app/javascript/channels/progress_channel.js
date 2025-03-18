import consumer from "channels/consumer"

consumer.subscriptions.create("ProgressChannel", {
  connected() {
    console.log("Progresso conectado");
  },

  disconnected() {
  },

  received(data) {
    console.log("Progresso recebido:", data);
  }
});
