using System.Data.SqlClient;
using System.Security.Cryptography;

namespace OnlineClinicBookingSystem
{
    internal class Program
    {
        static void Main(string[] args)
        {

            Console.WriteLine("Getting Connection");
            try
            {
                var dbConnection = new DatabaseConnection();
                var patientRepo = new Patient(dbConnection);
                patientRepo.getPatient();
                patientRepo.insertPatient();

            }
            catch (Exception ex) {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
        
    }
}
