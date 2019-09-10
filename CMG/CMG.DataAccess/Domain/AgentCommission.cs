using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class AgentCommission : EntityBase
    {
        public int Id { get; set; }
        public int? AgentId { get; set; }
        public int CommissionId { get; set; }
        public decimal? Commission { get; set; }
        public decimal? Split { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }

        public virtual Agent Agent { get; set; }
        public virtual Comm CommissionNavigation { get; set; }
    }
}
