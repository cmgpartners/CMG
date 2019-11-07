using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewAgentWithdrawalDto
    {
        public int Id { get; set; }
        public int WithdrawalId { get; set; }
        public int? AgentId { get; set; }
        public double? Amount { get; set; }
        public bool IsVisible { get; set; } = true;
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public bool IsDeleted { get; set; }
        public ViewAgentDto Agent { get; set; } = new ViewAgentDto();
    }
}
