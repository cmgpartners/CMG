using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewPolicyDto
    {
        public int PolicyId { get; set; }
        public string PolicyNumber { get; set; }
        public string CompanyName { get; set; }
        public string InsuredName { get; set; }
        public ICollection<ViewCommissionAgentDto> CommissionAgents { get; set; } = new List<ViewCommissionAgentDto>();
    }
}
