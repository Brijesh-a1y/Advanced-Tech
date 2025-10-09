using System.Data.SqlClient;

namespace OnlineClinicBookingSystem
{
    internal class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Getting Connection");
            var datasource = @"LAPTOP-LF8PDD3Q";
            var database = "Clinic";


            string connString = @"Data Source=" + datasource + ";Initial Catalog=" + database + "; Trusted_Connection=True";

            SqlConnection conn = new SqlConnection(connString);

            try
            {
                conn.Open();
                Console.WriteLine("Connection successfully");
                insertPatient(conn);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error : " + ex.Message);
            }
            finally { 
                conn.Close();
            }
        }
        static void insertPatient(SqlConnection conn)
        {
            string patN = "Rahul";
            string dob = "1890-04-12";
            string pN = "9994567890";
            string e = "rahul@gmail.com";

            string query = "insert into Patient(patientName,dateOfBirth,phoneNo,email) values (@patN,@dob,@pN,@e)";

            Console.WriteLine(query);
            SqlCommand command = new SqlCommand(query, conn);
            command.Parameters.AddWithValue("@patN", patN);
            command.Parameters.AddWithValue("@dob", dob);
            command.Parameters.AddWithValue("@pN", pN);
            command.Parameters.AddWithValue("@e", e);
            
            int row = command.ExecuteNonQuery();
            if (row > 0)
            {
                Console.WriteLine("Patient inserted successfully");
            }


        }
    }
}
