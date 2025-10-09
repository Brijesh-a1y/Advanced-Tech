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
        private double area;
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
        

        public  static Rectangle operator+(Rectangle first, Rectangle second) {
            Rectangle temp = new Rectangle();
            temp.area = first.length * first.Breadth + second.length * second.breadth;
            return temp;
        }
        public static Rectangle operator -(Rectangle first, Rectangle second){
            Rectangle temp = new Rectangle();
            temp.area = Math.Abs(first.length * first.Breadth - second.length * second.breadth);
            return temp;
        }
        public static Rectangle operator *(Rectangle first, Rectangle second){
            Rectangle temp = new Rectangle();
            temp.area = Math.Abs(first.length * first.Breadth * second.length * second.breadth);
            return temp;
        }
    }
}
