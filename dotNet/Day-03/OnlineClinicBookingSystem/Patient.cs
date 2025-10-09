using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OnlineClinicBookingSystem
{
    internal class Patient
    {

        private readonly DatabaseConnection _dbconnection;
        public Patient(DatabaseConnection dbConnection)
        {
            _dbconnection = dbConnection;
        }


        private int patientId;
        private string patientName;
        private string dateOfBirth;
        private string phoneNo;
        private string email;
        //private string aadharNo;

        //public Patient(string patientName, string dateOfBirth, string phoneNo, string email)
        //{
        //    this.patientName = patientName;
        //    this.dateOfBirth = dateOfBirth;
        //    this.phoneNo = phoneNo;
        //    this.email = email;
        //}

        public void getPatient()
        {
       
            Console.WriteLine("Enter Patient Name :");
            patientName = Console.ReadLine();

            Console.WriteLine("Enter Patient Date of Birth :");
            dateOfBirth = Console.ReadLine();
            
            Console.WriteLine("Enter Patient phone number :");
            phoneNo = Console.ReadLine();

            Console.WriteLine("Enter Patient email :");
            email = Console.ReadLine();
            
        }

        //public void insertPatient(string patientName, string dateOfBirth, string phoneNo, string email)
        //{
          
        //    string query = "insert into Patient(patientName,dateOfBirth,phoneNo,email) values (@patN,@dob,@pN,@e)";

          
        //    var conn = _dbconnection.GetConnection();
        //    SqlCommand command = new SqlCommand(query, conn);
        //    command.Parameters.AddWithValue("@patN", patientName);
        //    command.Parameters.AddWithValue("@dob", dateOfBirth);
        //    command.Parameters.AddWithValue("@pN", phoneNo);
        //    command.Parameters.AddWithValue("@e", email);
      
        //    int row = command.ExecuteNonQuery();
        //    if (row > 0)
        //    {
        //        Console.WriteLine("Patient inserted successfully");
        //    }


        //}
        public void insertPatient()
        {
          
            string query = "insert into Patient(patientName,dateOfBirth,phoneNo,email) values (@patN,@dob,@pN,@e)";

          
            var conn = _dbconnection.GetConnection();
            SqlCommand command = new SqlCommand(query, conn);
            command.Parameters.AddWithValue("@patN", patientName);
            command.Parameters.AddWithValue("@dob", dateOfBirth);
            command.Parameters.AddWithValue("@pN", phoneNo);
            command.Parameters.AddWithValue("@e", email);
      
            int row = command.ExecuteNonQuery();
            if (row > 0)
            {
                Console.WriteLine("Patient inserted successfully");
            }


        }

    }
}
