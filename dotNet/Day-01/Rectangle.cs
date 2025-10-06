using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    internal class Rectangle
    {
        /*
         Create a rectangle class and calculate the sum of two rectangle area
         */

        private double length;
        private double breadth;
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

        public double calculateArea()
        {
            return length * breadth;
        }
        public double areaSum(Rectangle other)
        {
            return this.length*this.Breadth + other.length*other.breadth;
        }

        public Rectangle sideSum(Rectangle other) {
            Rectangle temp = new Rectangle();
            temp.length = this.length+other.length;
            temp.breadth = this.breadth+other.breadth;
            return temp;
        }
    }
}
