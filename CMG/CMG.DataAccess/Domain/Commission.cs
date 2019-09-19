using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Commission : EntityBase
    {
        public Commission()
        {
            AgentCommission = new HashSet<AgentCommission>();
        }

        public int Id { get; set; }
        public string CommissionType { get; set; }
        public int? YearMonth { get; set; }
        public DateTime? PayDate { get; set; }
        public int? PolicyId { get; set; }
        public double? Premium { get; set; }
        public string RenewalType { get; set; }
        public double? Total { get; set; }
        public bool? IsDeleted { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public string Insured { get; set; }
        public virtual Policys Policy { get; set; }
        public virtual ICollection<AgentCommission> AgentCommission { get; set; }
    }
}
