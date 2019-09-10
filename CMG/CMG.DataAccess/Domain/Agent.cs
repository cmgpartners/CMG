using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Agent : EntityBase
    {
        public Agent()
        {
            AgentCommission = new HashSet<AgentCommission>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string AgentCode { get; set; }
        public bool IsDeleted { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }

        public virtual ICollection<AgentCommission> AgentCommission { get; set; }
    }
}
