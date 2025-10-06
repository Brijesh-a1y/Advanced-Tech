using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace ConsoleApp1
{
    internal class Student:Person 
    {
        private int id;
        public int studentID { 
            get { return id; }

            set {
                if (value != null) { 
                    id = value; 
                }
                else
                {   //default value
                    id = 111;
                }
            }
        
        }
        public int[] marks;
        //public static string department="cccccccs";
        public Student()
        {
            this.id = 0;
            //this.Name = "";            
            marks = new int[0];
        }
        public Student(int id,string name)
        {

            this.id = id;
            this.Name = name;
            marks = new int[0];
        }

        public Student(int id,string name,int[] marks,string gender) : base(name, gender)

        {

            this.id = id;
            //this.Name = name;
            this.marks = marks;
            //this.gender = gender;
        }
        
        public double calculateTotal()
        {
            double total = 0;
            for (int i = 0; i < marks.Length; i++)
            {
                total += marks[i];
            }
            return total;
        }
        public void calculateAverage()
        {
            double total = calculateTotal();
            double avg = total / marks.Length;
            Console.WriteLine("Total marks of student id "+id+" is "+total);
            Console.WriteLine("Average marks of student id "+id+" is "+avg+"\n");

        }
        public void calculateAverage(double total)
        {
            double avg = total / marks.Length;
            Console.WriteLine("Average marks of student id " + id + " is " + avg + "\n");

        }

    }
}
