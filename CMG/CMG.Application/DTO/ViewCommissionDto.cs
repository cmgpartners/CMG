using System;
using System.Collections.Generic;

namespace CMG.Application.DTO
{
    public class ViewCommissionDto 
    {
        public int CommissionId { get; set; }
        public DateTime PayDate { get; set; } = DateTime.Today;
        public int PolicyId { get; set; }
        public string PolicyNumber { get; set; }
        public string  CompanyName{ get; set; }
        public string InsuredName { get; set; }
        public string Renewal { get; set; } = "A";
        public string CommissionType { get; set; } = "R";
        public decimal TotalAmount { get; set; }
        public string Comment { get; set; }
        public string YearMonth { get; set; }
        public decimal Premium { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; } = null;
        public string ModifiedBy { get; set; } = null;
        public bool IsDeleted { get; set; }
        public bool IsNew { get; set; } = false;

        public bool IsNotNew { get; set; } = true;
        public ICollection<ViewAgentCommissionDto> AgentCommissions { get; set; } = new List<ViewAgentCommissionDto>();
    }
}
