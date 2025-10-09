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


            r1.calculateArea();
            
            
    }
}
}
