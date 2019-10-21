using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewPolicyAgentDto
    {
        public int Id { get; set; }
        public int PolicyId { get; set; }
        public decimal Split { get; set; }
        public int AgentId { get; set; }
        public int AgentOrder { get; set; }
        public ViewAgentDto Agent { get; set; } = new ViewAgentDto();
    }
}
