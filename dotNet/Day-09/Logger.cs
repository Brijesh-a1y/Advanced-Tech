public class Logger
{
    // 1. Private static instance
    private static Logger _instance;
    
    // 2. Private constructor - prevents external creation
    private Logger() 
    {
        Console.WriteLine("Logger instance created!");
    }
    
    // 3. Public static property to access the instance
    public static Logger Instance
    {
        get
        {
            // Create instance if it doesn't exist
            if (_instance == null)
            {
                _instance = new Logger();
            }
            return _instance;
        }
    }
    
    // 4. Instance method
    public void Log(string message)
    {
        Console.WriteLine($"[LOG] {DateTime.Now}: {message}");
    }
}