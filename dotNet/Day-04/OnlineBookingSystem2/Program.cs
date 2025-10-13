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

                // 1. Handle Patient Creation
                var patient = new Patient(dbConnection);
                var appointment = new Appointment(dbConnection);
                Console.WriteLine("-----------------Menu----------------");
                int choice;

                while (true)
                {
                    Console.WriteLine("\n1. Add New Patient :");
                    Console.WriteLine("2. Update Appointment Status:");
                    Console.WriteLine("3. View Appointments :");
                    Console.WriteLine("4. Exit :");
                    Console.WriteLine("Enter your choice :");
                    choice = Convert.ToInt32(Console.ReadLine());
                    switch (choice)
                    {
                        case 1:
                            patient.getPatient(); // Get patient details from console
                            int newPatientId = patient.insertPatient(); // Insert and get the ID

                            if (newPatientId != -1)
                            {
                                // 2. Handle Appointment Booking

                                appointment.PatientId = newPatientId; // Pass the retrieved ID
                                appointment.GetAppointmentData(); // Get appointment details
                                appointment.BookAppointment(); // Book the appointment
                            }
                            else
                            {
                                Console.WriteLine("Failed to create patient. Cannot book appointment.");
                            }
                            break;

                        case 2:

                            appointment.UpdateStatus();
                            break;
                        case 3:
                            appointment.View();
                            break;
                        case 4:
                            return;
                        default:
                            Console.WriteLine("Invalid Input");
                            break;
                    }
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }
        }
    }
}
