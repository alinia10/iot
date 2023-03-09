using System.Text;
using MQTTnet;
using MQTTnet.Client.Options;
using MQTTnet.Extensions.ManagedClient;
using Newtonsoft.Json.Linq;

class Program
{
    static async Task Main(string[] args)
    {
        // Configure the MQTT client options
        var options = new MqttClientOptionsBuilder()
            .WithTcpServer("localhost", 1883)
            .WithClientId("csharp_client")
            .Build();

        // Create a new MQTT client instance
        var client = new MqttFactory().CreateManagedMqttClient();
        
        // Connect to the MQTT broker
        await client.StartAsync(
            new ManagedMqttClientOptionsBuilder()
                .WithAutoReconnectDelay(TimeSpan.FromSeconds(5))
                .WithClientOptions(options)
                .Build());

        // Subscribe to the topic where JSON messages are received
        await client.SubscribeAsync("mqtt/LED", MQTTnet.Protocol.MqttQualityOfServiceLevel.ExactlyOnce);

        // Listen for incoming MQTT messages
        client.UseApplicationMessageReceivedHandler(e =>
        {
            // Check if the message contains a JSON payload
            if (e.ApplicationMessage.Payload != null)
            {
                string payload = Encoding.UTF8.GetString(e.ApplicationMessage.Payload);
                try
                {
                    // Parse the JSON payload
                    JObject json = JObject.Parse(payload);

                    // Publish the JSON payload to the "mqtt/LED" topic
                    client.PublishAsync(new MqttApplicationMessageBuilder()
                        .WithTopic("mqtt/LED")
                        .WithPayload(json.ToString())
                        .WithQualityOfServiceLevel(MQTTnet.Protocol.MqttQualityOfServiceLevel.ExactlyOnce)
                        .Build());
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error parsing JSON payload: {ex.Message}");
                }
            }
        });

        Console.WriteLine("Press any key to exit.");
        Console.ReadLine();

        // Disconnect from the MQTT broker
        await client.StopAsync();
    }
}
