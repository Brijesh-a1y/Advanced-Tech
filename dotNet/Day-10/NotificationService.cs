using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IOC
{
    internal class NotificationService
    {
        private readonly IMessageService _messageService;

        // Dependency is injected through constructor
        public NotificationService(IMessageService messageService)
        {
            _messageService = messageService;
        }

        public void Notify(string message)
        {
            _messageService.SendMessage(message);
        }
    }
}
