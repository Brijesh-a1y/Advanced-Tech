using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    public class Rectangle:Shape
    {
        /*
         Create a rectangle class and calculate the sum of two rectangle area
         */

        private double length;
        private double breadth;
        private double area;
       
        //property
        public double Length
        {
            get { return length; }
            set { length = value; }
        }
        public double Breadth
        {
            get { return breadth; }
            set { breadth = value; }
        }
        public double Area
        {
            get { return area; }

        }
        
        //interface method override
        public  void calculateArea()
        {
            Console.WriteLine( length * breadth);
        }
      
    }
}
