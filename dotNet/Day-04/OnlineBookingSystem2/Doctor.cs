using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OnlineClinicBookingSystem
{
    internal class Doctor
    {
        private int doctorId;
        private string doctorName;
        private string specialization;
        private string phoneNo;
        private string email;

        public int DoctorId {  get { return doctorId; } set { doctorId = value; } } 
        public string DoctorName { get { return doctorName; } set { doctorName = value; } }
        public string Specialization { get { return specialization; } set { specialization = value; } } 
        public string PhoneNo { get { return phoneNo; } set { phoneNo = value; } }  
        public string Email { get { return email; } set { email = value; } }    


        public Doctor() { }
        public Doctor(string doctorName,string specialization,string phoneNo,string email)
        {
            this.doctorName = doctorName;
            this.specialization = specialization;
            this.phoneNo = phoneNo;
            this.email = email;
        }
        public void showDoctorDetails()
        {
            Console.WriteLine("Show Doctor Details");
        }
    }
}
