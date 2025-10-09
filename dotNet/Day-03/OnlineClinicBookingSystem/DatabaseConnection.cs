using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace OnlineClinicBookingSystem
{
    internal class DatabaseConnection
    {
        private readonly string _connectionString;
        public DatabaseConnection() {
            var datasource = @"LAPTOP-LF8PDD3Q";
            var database = "Clinic";
            _connectionString = @"Data Source=" + datasource + ";Initial Catalog=" + database + "; Trusted_Connection=True";
        
        }
        public SqlConnection GetConnection() { 
            var conn =  new SqlConnection(_connectionString);
            conn.Open();
            return conn;
        }
    }
}
