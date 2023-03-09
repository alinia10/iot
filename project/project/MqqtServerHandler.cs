using MQTTnet.Client.Publishing;
using MQTTnet.Client.Receiving;
using MQTTnet.Protocol;
using MQTTnet.Server.Status;

namespace project;
using MQTTnet;
using MQTTnet.Server;
using System;
using System.Threading.Tasks;
public class MqttServerHandler : IMqttServer
{
    private IMqttServer mqttServer;
    private PostgresConnection postgresConnection;
    
    public MqttServerHandler(string connectionString)
    {
        var optionsBuilder = new MqttServerOptionsBuilder()
            .WithConnectionBacklog(100)
            .WithDefaultEndpointPort(1883)
            .WithConnectionValidator(c =>
            {
                if (c.Username != "myusername" || c.Password != "mypassword")
                {
                    c.ReasonCode = MqttConnectReasonCode.BadUserNameOrPassword;
                    return;
                }
                
                c.ReasonCode = MqttConnectReasonCode.Success;
            });
        
        mqttServer = new MqttFactory().CreateMqttServer();
        mqttServer.ClientConnectedHandler = new MqttServerClientConnectedHandlerDelegate(args =>
        {
            Console.WriteLine($"Client '{args.ClientId}' connected with protocol '{args.ProtocolVersion}'");
        });
        mqttServer.ClientDisconnectedHandler = new MqttServerClientDisconnectedHandlerDelegate(args =>
        {
            Console.WriteLine($"Client '{args.ClientId}' disconnected");
        });
        mqttServer.ApplicationMessageReceivedHandler = new MqttApplicationMessageReceivedHandlerDelegate(args =>
        {
            Console.WriteLine($"Received MQTT message: {args.ApplicationMessage.Payload}");
            string query = $"INSERT INTO mytable (column1, column2) VALUES ('{args.ApplicationMessage.Topic}', '{args.ApplicationMessage.Payload}')";        
            postgresConnection.ExecuteQuery(query);
        });
        
        postgresConnection = new PostgresConnection("localhost", "5432", "mydatabase", "myusername", "mypassword");
        postgresConnection.OpenConnection();
    }
    
    // Start MQTT server
    public async Task Start()
    {
        await mqttServer.StartAsync(new MqttServerOptionsBuilder().Build());
        Console.WriteLine("MQTT server started.");
    }
    
    // Stop MQTT server
    public async Task Stop()
    {
        await mqttServer.StopAsync();
        Console.WriteLine("MQTT server stopped.");
        
        postgresConnection.CloseConnection();
    }

    public IMqttApplicationMessageReceivedHandler ApplicationMessageReceivedHandler { get; set; }
    public Task<MqttClientPublishResult> PublishAsync(MqttApplicationMessage applicationMessage, CancellationToken cancellationToken)
    {
        throw new NotImplementedException();
    }

    public void Dispose()
    {
        throw new NotImplementedException();
    }

    public Task<IList<IMqttClientStatus>> GetClientStatusAsync()
    {
        throw new NotImplementedException();
    }

    public Task<IList<IMqttSessionStatus>> GetSessionStatusAsync()
    {
        throw new NotImplementedException();
    }

    public Task<IList<MqttApplicationMessage>> GetRetainedApplicationMessagesAsync()
    {
        throw new NotImplementedException();
    }

    public Task ClearRetainedApplicationMessagesAsync()
    {
        throw new NotImplementedException();
    }

    public Task SubscribeAsync(string clientId, ICollection<MqttTopicFilter> topicFilters)
    {
        throw new NotImplementedException();
    }

    public Task UnsubscribeAsync(string clientId, ICollection<string> topicFilters)
    {
        throw new NotImplementedException();
    }

    public Task StartAsync(IMqttServerOptions options)
    {
        throw new NotImplementedException();
    }

    public Task StopAsync()
    {
        throw new NotImplementedException();
    }

    public bool IsStarted { get; }
    public IMqttServerStartedHandler StartedHandler { get; set; }
    public IMqttServerStoppedHandler StoppedHandler { get; set; }
    public IMqttServerClientConnectedHandler ClientConnectedHandler { get; set; }
    public IMqttServerClientDisconnectedHandler ClientDisconnectedHandler { get; set; }
    public IMqttServerClientSubscribedTopicHandler ClientSubscribedTopicHandler { get; set; }
    public IMqttServerClientUnsubscribedTopicHandler ClientUnsubscribedTopicHandler { get; set; }
    public IMqttServerOptions Options { get; }
}