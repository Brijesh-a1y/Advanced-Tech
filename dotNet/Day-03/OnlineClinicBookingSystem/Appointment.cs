using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OnlineClinicBookingSystem
{
    internal class Appointment
    {
        private int appointmentId;
        private int patientId;
        private DateTime appointmentDateTime;
        private string status;
        private string reasonsForVisit;

        //properties of variable
        public int AppointmentId {  get { return appointmentId; } set { appointmentId = value; } }
        public int PatientId { get {return patientId; } set { patientId = value; } }
        public DateTime AppointmentDateTime { get { return appointmentDateTime; } set { appointmentDateTime = value; } }
        public string Status { get { return status; } set { status = value; } }
        public string ReasonsForVisit { get { return reasonsForVisit; } set { reasonsForVisit = value; } }  

        public Appointment() { }
        public Appointment(int patientId,DateTime appointmentDateTime,string status)
        {
            this.patientId = patientId;
            this.appointmentDateTime = appointmentDateTime;
            this.status = status;
        }
        public void showAllAppointment()
        {
            Console.WriteLine("This method show all Appointment");
        }

    }
}
