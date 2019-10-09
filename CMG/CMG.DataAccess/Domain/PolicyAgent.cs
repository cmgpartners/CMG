using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class PolicyAgent
    {
        public int Id { get; set; }
        public int PolicyId { get; set; }
        public int? AgentId { get; set; }
        public double? Split { get; set; }
        public int? AgentOrder { get; set; }
        public bool? IsDeleted { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public bool IsServiceAgent { get; set; }

        public virtual Agent Agent { get; set; }
        public virtual Policys Policy { get; set; }
    }
}
