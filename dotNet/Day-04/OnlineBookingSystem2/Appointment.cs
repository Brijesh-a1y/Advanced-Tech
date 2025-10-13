using System;
using System.Data.SqlClient;

namespace OnlineClinicBookingSystem
{
    internal class Appointment
    {
        private readonly DatabaseConnection _dbconnection;

        // Use public properties with private setters for better control
        public int AppointmentId { get; private set; }
        public int PatientId { get; set; } // Public setter for now, but could be private
        public DateTime AppointmentDateTime { get; private set; }
        public string Status { get; private set; }
        public string ReasonForVisit { get; private set; }

        public Appointment(DatabaseConnection dbConnection)
        {
            _dbconnection = dbConnection;
        }

        // Method to get user input for a new appointment
        public void GetAppointmentData()
        {
            Console.WriteLine("Enter AppointmentDateTime (YYYY-MM-DD HH:mm:ss):");
            AppointmentDateTime = Convert.ToDateTime(Console.ReadLine());

            Console.WriteLine("Enter Status (e.g., 'Scheduled'):");
            Status = Console.ReadLine();

            Console.WriteLine("Enter Reason for visit:");
            ReasonForVisit = Console.ReadLine();
        }

        // Method to book a new appointment
        public void BookAppointment()
        {
            // Corrected SQL query with proper syntax
            string query = "INSERT INTO Appointment (patientId, appointmentDateTime, status, reasonForVisit) " +
                           "VALUES (@patId, @adt, @s, @rfv)";

            try
            {
                using (var conn = _dbconnection.GetConnection())
                using (var command = new SqlCommand(query, conn))
                {
                    command.Parameters.AddWithValue("@patId", PatientId);
                    command.Parameters.AddWithValue("@adt", AppointmentDateTime);
                    command.Parameters.AddWithValue("@s", Status);
                    command.Parameters.AddWithValue("@rfv", ReasonForVisit);

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine("Appointment booked successfully.");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error booking appointment: {ex.Message}");
            }
        }

        // Method to update the status of a *specific* appointment
        public void UpdateStatus()
        {
            Console.WriteLine("Enter AppointmentID :");
            int appointmentId = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Set Status (Scheduled,Canceled,Completed)");
            string newStatus = Console.ReadLine();
            string query = "UPDATE Appointment SET status = @newStatus WHERE appointmentId = @appId";

            try
            {
                using (var conn = _dbconnection.GetConnection())
                using (var command = new SqlCommand(query, conn))
                {
                    command.Parameters.AddWithValue("@newStatus", newStatus);
                    command.Parameters.AddWithValue("@appId", appointmentId);

                    int rowsAffected = command.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        Console.WriteLine($"Appointment {appointmentId} status updated to '{newStatus}'.");
                    }
                    else
                    {
                        Console.WriteLine($"No appointment found with ID {appointmentId} to update.");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating appointment status: {ex.Message}");
            }
        }
        public void View()
        {
            string query = "SELECT appointmentId, patientId, appointmentDateTime, status, reasonForVisit FROM Appointment";
            try
            {
                var conn = _dbconnection.GetConnection();
                var command = new SqlCommand(query, conn);
                var reader = command.ExecuteReader();
                Console.Write("--------------------------------------------------------------------------------------------------------");
                Console.WriteLine("\nAppointmentID \t patientId \t appointmentDateTime \t\t status \t\t reasonForVisit");
                Console.WriteLine("--------------------------------------------------------------------------------------------------------");
                while (reader.Read())
                {

                    int appointmentId = (int)reader["appointmentId"];
                    int patientId = (int)reader["patientId"];
                    DateTime appointmentDateTime = (DateTime)reader["appointmentDateTime"];
                    string status = (string)reader["status"];
                    string reasonForVisit = (string)reader["reasonForVisit"];
                    Console.WriteLine($"{appointmentId}\t\t {patientId}\t\t {appointmentDateTime}\t\t {status}\t\t {reasonForVisit}");
                }
                Console.WriteLine("--------------------------------------------------------------------------------------------------------");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
