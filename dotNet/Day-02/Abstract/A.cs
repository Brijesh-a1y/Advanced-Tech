using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    abstract internal class A
    {
        public int sum(int a, int b) { return a + b; }
        abstract public int mul(int a, int b);
    }
}
