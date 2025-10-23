using System.IO.Pipes;

namespace IOC
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            NotificationService ns = new NotificationService(new EmailService());
            ns.Notify("Email service"); 
        }
    }
}
