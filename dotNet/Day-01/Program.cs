namespace ConsoleApp1
{
    internal class Program
    {
        static void Main(string[] args)
        {



            Rectangle r1 = new Rectangle();
            
            Console.WriteLine("Enter Length of Rectangle1 :");
            r1.Length = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter Breadth of Rectangle1 :");
            r1.Breadth = Convert.ToInt32(Console.ReadLine());


            Rectangle r2 = new Rectangle();

            Console.WriteLine("\nEnter Length of Rectangle2 :");
            r2.Length = Convert.ToInt32(Console.ReadLine());

            Console.WriteLine("Enter Breadth of Rectangle2 :");
            r2.Breadth = Convert.ToInt32(Console.ReadLine());


            //1st way
            //double Area1 = r1.calculateArea();
            //double Area2 = r2.calculateArea();
            //Console.WriteLine("\nSum of Area : "+ (Area1+Area2));


            //2nd way
            double AreaSum = r1.areaSum(r2);
            Console.WriteLine("\nSum of Area : "+AreaSum);

            Rectangle r3 = new Rectangle();
            r3 = r1.sideSum(r2);

            Console.WriteLine("r3 length :"+r3.Length);
            Console.WriteLine("r3 breadth :"+r3.Breadth);







            //SBI sbi = new SBI();
            //sbi.paymentMethod();


            //Student.department = "Computer Science";

            //Student s1 = new Student();
            //Student s2 = new Student(101, "Ram");

            //int[] marks = new int[] {99, 42, 53 };

            //Student s3 = new Student(101,"Milly",marks,"Female");
            ////s3.studentID = 444;


            //Console.WriteLine(s3.studentID);
            ////s1.calculateAverage();
            ////s2.calculateAverage();
            //s3.calculateAverage();
            //Console.WriteLine(s3.Name);
            //Console.WriteLine(s3.gender);

            //double total = s3.calculateTotal();
            //s3.calculateAverage(total);
            //Console.WriteLine(s1.id);
            //without Array
            //double mark1, mark2, mark3;
            //Console.WriteLine("Enter mark1");
            //mark1 = Convert.ToInt32(Console.ReadLine());

            //Console.WriteLine("Enter mark2");
            //mark2 = Convert.ToInt32(Console.ReadLine());

            //Console.WriteLine("Enter mark3");
            //mark3 = Convert.ToInt32(Console.ReadLine());

            //double total = mark1 + mark2 + mark3;
            //double averageMarks = total / 3.0;


            //Console.WriteLine("Total marks "+total);
            //Console.WriteLine("Average of student's marks "+averageMarks);




            //with array

            //int[] marks = new int[3]; 
            //int[] marks = new int[3] { 34, 55, 66 }; // with initialization
            //Console.WriteLine("Enter mark1");
            //marks[0] = Convert.ToInt32(Console.ReadLine());

            //Console.WriteLine("Enter mark2");
            //marks[1] = Convert.ToInt32(Console.ReadLine());

            //Console.WriteLine("Enter mark3");
            //marks[2] = Convert.ToInt32(Console.ReadLine());

            //double total = marks[0] + marks[1] + marks[2];
            //double total=0;
            //for (int i = 0; i < marks.Length; i++) {
            //    total += marks[i];
            //}
            //double averageMarks = total / marks.Length;


            //Console.WriteLine("Total marks " + total);
            //Console.WriteLine("Average of student's marks " + averageMarks);



            // with method
            //int[] marks = inputUserMarks();
            ////double total = calculateTotal(marks);
            ////double averageMarks = calculateAverage(total,marks.Length);
            //double averageMarks = calculateAverage(marks);
            ////Console.WriteLine("Total marks " + total);
            //Console.WriteLine("Average of student's marks " + averageMarks);
            //Program p1 = new Program();
            //p1.nonStaticMethod();
        }

        //static int[] inputUserMarks()
        //{
        //    int[] marks = new int[3];
        //    Console.WriteLine("Enter mark1");
        //    marks[0] = Convert.ToInt32(Console.ReadLine());

        //    Console.WriteLine("Enter mark2");
        //    marks[1] = Convert.ToInt32(Console.ReadLine());

        //    Console.WriteLine("Enter mark3");
        //    marks[2] = Convert.ToInt32(Console.ReadLine());

        //    return marks;
        //}
        //static double calculateTotal(int[] marks)
        //{
        //    double total = 0;
        //    for (int i = 0; i < marks.Length; i++) { 
        //        total += marks[i];
        //    }
        //    return total;
        //}
        //static double calculateAverage(int[] marks)
        //{
        //    double total = calculateTotal(marks);
        //    double avg = total / marks.Length;
        //    return avg;
        //}

        //void nonStaticMethod()
        //{
        //    Console.WriteLine("Hello i'm non-static method");
        //}
    }
}
