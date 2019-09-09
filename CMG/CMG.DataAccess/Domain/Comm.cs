using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Comm : EntityBase
    {
        public Comm()
        {
            AgentCommission = new HashSet<AgentCommission>();
        }

        public int Keycomm { get; set; }
        public string Commtype { get; set; }
        public string Yrmo { get; set; }
        public DateTime? Paydate { get; set; }
        public string Policynum { get; set; }
        public string Company { get; set; }
        public string Insured { get; set; }
        public decimal Premium { get; set; }
        public string Renewals { get; set; }
        public decimal Total { get; set; }
        public decimal Marty { get; set; }
        public decimal Peter { get; set; }
        public decimal Frank { get; set; }
        public decimal Bob { get; set; }
        public decimal Mary { get; set; }
        public decimal Other { get; set; }
        public string Agent1 { get; set; }
        public string Agent2 { get; set; }
        public string Agent3 { get; set; }
        public string Agent4 { get; set; }
        public string Agent5 { get; set; }
        public decimal Split1 { get; set; }
        public decimal Split2 { get; set; }
        public decimal Split3 { get; set; }
        public decimal Split4 { get; set; }
        public decimal Split5 { get; set; }
        public int Keynumo { get; set; }
        public int Keynump { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public bool Del { get; set; }
        public string Agent6 { get; set; }
        public decimal Split6 { get; set; }
        public decimal Kate { get; set; }

        public virtual ICollection<AgentCommission> AgentCommission { get; set; }
    }
}
