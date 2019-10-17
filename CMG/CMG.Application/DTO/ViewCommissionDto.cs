using System;
using System.Collections.Generic;

namespace CMG.Application.DTO
{
    public class ViewCommissionDto
    {
        public int CommissionId { get; set; }
        public DateTime PayDate { get; set; }
        public int PolicyId { get; set; }
        public string PolicyNumber { get; set; }
        public string  CompanyName{ get; set; }
        public string InsuredName { get; set; }
        public string Renewal { get; set; }
        public string CommissionType { get; set; }
        public decimal TotalAmount { get; set; }
        public string Comment { get; set; }
        public string YearMonth { get; set; }
        public decimal Premium { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; } = null;
        public string ModifiedBy { get; set; } = null;
        public bool IsDeleted { get; set; }
        public ICollection<ViewAgentCommissionDto> AgentCommissions { get; set; } = new List<ViewAgentCommissionDto>();
    }
}
