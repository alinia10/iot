namespace project;

public class MqqtConnection
{
    
}

// var option = new MqttServerOptionsBuilder()
//     .WithDefaultEndpoint()
//     .WithApplicationMessageInterceptor(onNewMessage);
// var mqttServer = new MqttFactory().CreateMqttServer();
//
// await    mqttServer.StartAsync(option.Build());
//
// static void onNewMessage(MqttApplicationMessageInterceptorContext context)
// {
//     var payload = context.ApplicationMessage?.Payload == null
//         ? null
//         : Encoding.UTF8.GetString(context.ApplicationMessage?.Payload);
//
//     if (payload == "on")
//     {
//         
//     }
//     else
//     {
//         
//     }
//     
//     WriteLine(
//         "{0} \n {1}",
//         DateTime.Now,
//         context.ClientId);
// }