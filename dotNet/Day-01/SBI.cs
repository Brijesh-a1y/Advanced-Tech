using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class SBI:PaymentSystem
    {
        public SBI() {
            Console.WriteLine("Default SBI constructor called");
        }
        public void paymentMethod()
        {
            Console.WriteLine("Sbi payment System");
        }
    }
}
