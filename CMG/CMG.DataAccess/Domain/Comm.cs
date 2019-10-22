using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CMG.DataAccess.Domain
{
    public partial class Comm : EntityBase
    {
        [Key]
        public int Keycomm { get; set; }
        public string Commtype { get; set; }
        public string Yrmo { get; set; }
        public DateTime? Paydate { get; set; }
        [ForeignKey("Policy")]
        public int Keynumo { get; set; }
        public decimal Premium { get; set; }
        public string Renewals { get; set; }
        public decimal Total { get; set; }
        public bool? Del { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime RevDate { get; set; }
        public string RevLocn { get; set; }
        public string Insured { get; set; }
        public string Comment { get; set; }
        public string Policynum { get; set; }
        public string Company { get; set; }
        public int Keynump { get; set; }

        public virtual Policys Policy { get; set; }
        public virtual IEnumerable<AgentCommission> AgentCommissions { get; set; } = new List<AgentCommission>();
    }
}
