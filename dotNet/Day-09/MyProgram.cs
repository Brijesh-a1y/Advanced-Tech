class Program
{
    static void Main()
    {
        // Get the singleton instance
        Logger logger = Logger.Instance;
        logger.Log("Application started");
        
        // Get same instance again
        Logger sameLogger = Logger.Instance;
        sameLogger.Log("Another message");
        
        // Check if it's the same object
        Console.WriteLine($"Same instance? {logger == sameLogger}"); // True
    }
}