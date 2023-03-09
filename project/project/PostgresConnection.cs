namespace project;
using Npgsql;

public class PostgresConnection
{
    private NpgsqlConnection connection;
    private string connectionString;
    
    public PostgresConnection(string server, string port, string database, string username, string password)
    {
        connectionString = $"Server={server};Port={port};Database={database};User Id={username};Password={password};";
    }
    
    public void OpenConnection()
    {
        connection = new NpgsqlConnection(connectionString);
        connection.Open();
        Console.WriteLine("PostgreSQL database connection opened.");
    }
    
    public void CloseConnection()
    {
        connection.Close();
        Console.WriteLine("PostgreSQL database connection closed.");
    }
    
    // Execute SQL query and return result as NpgsqlDataReader
    public NpgsqlDataReader ExecuteQuery(string query)
    {
        NpgsqlCommand command = new NpgsqlCommand(query, connection);
        return command.ExecuteReader();
    }
}