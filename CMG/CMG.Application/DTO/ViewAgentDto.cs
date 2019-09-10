using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewAgentDto
    {
        public int? Id;
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string AgentCode { get; set; }
        public bool IsDeleted { get; set; }
        public string CurrentUser { get; set; }
    }
}
