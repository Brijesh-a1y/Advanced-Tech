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


            //+ operator overloaded
            Rectangle r3 = new Rectangle();
            r3 = r1 + r2;
            Console.WriteLine(r3.Area);

            //-operator overloaded
            Rectangle r4 = new Rectangle();
            r4 = r1 - r2;
            Console.WriteLine(r4.Area);

            //*operator overloaded
            Rectangle r5 = new Rectangle();
            r5 = r1 * r2;
            Console.WriteLine(r5.Area);



    }
}
