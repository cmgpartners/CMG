using System;

namespace CMG.Application.DTO
{
    public class ViewAgentCommissionDto
    {
        public int Id { get; set; }
        public int CommissionId { get; set; }
        public decimal Commission { get; set; }
        public decimal Split { get; set; }
        public int AgentId { get; set; }
        public int AgentOrder { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string? CreatedBy { get; set; }
        public bool IsDeleted { get; set; }
        public ViewAgentDto Agent { get; set; } = new ViewAgentDto();
    }
}
