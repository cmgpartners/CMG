using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class Withd : EntityBase
    {
        public Withd()
        {
            AgentWithdrawal = new HashSet<AgentWithdrawal>();
        }
        [Key]
        public int Keywith { get; set; }
        public string Dtype { get; set; }
        public string Yrmo { get; set; }
        public string Desc { get; set; }
        public string Ctype { get; set; }
        public virtual IEnumerable<AgentWithdrawal> AgentWithdrawal { get; set; }
    }
}
