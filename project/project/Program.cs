using System;
using System.Text;
using System.Threading;
using MQTTnet;
using MQTTnet.Client.Receiving;
using MQTTnet.Server;
using Newtonsoft.Json;

namespace MqttServerExample
{
    class Program
    {
        static void Main(string[] args)
        {
            MainAsync(args).GetAwaiter().GetResult();
        }
        
        static async Task MainAsync(string[] args)
        {
            var options = new MqttServerOptionsBuilder()
                .WithDefaultEndpoint()
                .WithDefaultEndpointPort(1883)
                .Build();

            var mqttServer = new MqttFactory().CreateMqttServer();
            mqttServer.ClientConnectedHandler = new MqttServerClientConnectedHandlerDelegate(e =>
            {
                Console.WriteLine($"Client '{e.ClientId}' connected.");
            });
            mqttServer.ClientDisconnectedHandler = new MqttServerClientDisconnectedHandlerDelegate(e =>
            {
                Console.WriteLine($"Client '{e.ClientId}' disconnected.");
            });
            mqttServer.ApplicationMessageReceivedHandler = new MqttApplicationMessageReceivedHandlerDelegate(async e =>
            {
                string messagePayload = Encoding.UTF8.GetString(e.ApplicationMessage.Payload);
                dynamic messageJson = JsonConvert.DeserializeObject(messagePayload);
                Console.WriteLine($"Received message: {messageJson}");

                // Publish message to all clients
                var message = new MqttApplicationMessageBuilder()
                    .WithTopic(e.ApplicationMessage.Topic)
                    .WithPayload(Encoding.UTF8.GetBytes(messagePayload))
                    .WithExactlyOnceQoS()
                    .WithRetainFlag()
                    .Build();
                await mqttServer.PublishAsync(message, CancellationToken.None);
            });

            await mqttServer.StartAsync(options);
            Console.WriteLine("MQTT broker started.");

            Console.ReadLine();

            await mqttServer.StopAsync();
            Console.WriteLine("MQTT broker stopped.");
        }
    }
}