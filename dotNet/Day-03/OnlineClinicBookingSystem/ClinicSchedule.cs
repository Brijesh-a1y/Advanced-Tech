using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OnlineClinicBookingSystem
{
    internal class ClinicSchedule
    {
        private int scheduleId;
        private DayOfWeek dayOfWeek;
        private TimeOnly startTime;
        private TimeOnly endTime;

        public int ScheduledId {  get { return scheduleId; } set { scheduleId = value; } }
        public DayOfWeek DayOfWeek { get { return dayOfWeek; } set { dayOfWeek = value; } }
        public TimeOnly StartTime { get { return startTime; } set { startTime = value; } }
        public TimeOnly EndTime{ get { return endTime; } set { endTime = value; }}  
        

        public void showSchedule()
        {
            Console.WriteLine("This method show All schedule");
        }
    }
}
