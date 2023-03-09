using project;
using System;
class Project
    {
        static async Task Main(string[] args)
        {
            var server = System.Environment.GetEnvironmentVariable("server");
            var port = System.Environment.GetEnvironmentVariable("port");
            var username = System.Environment.GetEnvironmentVariable("username");
            var pass = System.Environment.GetEnvironmentVariable("pass");
            MqttServerHandler mqttServerHandler = new MqttServerHandler($"Server={server};Port={port};Username={username};Password={pass};");
            await mqttServerHandler.Start();
        
            Console.WriteLine("Press any key to stop the MQTT server.");
            Console.ReadKey();

        }
    }

