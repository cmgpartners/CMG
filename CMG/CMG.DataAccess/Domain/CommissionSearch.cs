using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace CMG.DataAccess.Domain
{
    public class CommissionSearch
    {
        public int Id { get; set; }
        public int? PolicyId { get; set; }
        public DateTime? PayDate { get; set; }
        public string PolicyNumber { get; set; }
        public string CommissionType { get; set; }
        public string Company { get; set; }
        public string Insured { get; set; }
        public string RenewalType { get; set; }
        public decimal? Total { get; set; }
        public ICollection<AgentCommission> AgentCommissions { get; set; }
    }
}
