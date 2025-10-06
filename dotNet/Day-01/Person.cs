using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Person
    {
        public string Name;
        public string gender;  
        public Person() { Console.WriteLine("Base constructor"); }
        public Person(string name,string gender) { this.Name = name; this.gender = gender; }
    }
}
