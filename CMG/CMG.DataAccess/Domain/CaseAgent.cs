using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class CaseAgent
    {
        public int Id { get; set; }
        public int CaseId { get; set; }
        public int? AgentId { get; set; }
        public int? AgentOrder { get; set; }
        public bool? IsDeleted { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }

        public virtual Agent Agent { get; set; }
        public virtual Cases Case { get; set; }
    }
}
