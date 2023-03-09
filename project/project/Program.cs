using MQTTnet;
using MQTTnet.Server;
using System.Text;
using static System.Console;
using Npgsql;
using project;

class Project
    {
        public static void Main(string[] args)
        {
            PostgresConnection conn = new PostgresConnection("localhost", "5432", "mydatabase", "myusername", "mypassword");
            conn.OpenConnection();
            NpgsqlDataReader reader = conn.ExecuteQuery("SELECT * FROM history");
            while (reader.Read())
            {
                Console.WriteLine($"Column 1: {reader.GetString(0)}, Column 2: {reader.GetString(1)}");
            }
        
            conn.CloseConnection();
            
        }
    }

