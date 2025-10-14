using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class Class : ControllerBase
    {
        [HttpPost]
        public string postmethod([FromBody]string name,int age)
        {
            Console.WriteLine(name);
            Console.WriteLine(age);
            return name;
        }
    }
}
