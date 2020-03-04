﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class Policys : EntityBase
    {
        public Policys()
        {
            Commissions = new HashSet<Comm>();
            PolIll = new HashSet<PolIll>();
            PolicyAgent = new HashSet<PolicyAgent>();
        }
        [Key]
        public int Keynumo { get; set; }
        public int Restricted { get; set; }
        public string Policynum { get; set; }
        public string Plancode { get; set; }
        public DateTime? Issuedate { get; set; }
        public string Type { get; set; }
        public string Frequency { get; set; }
        public string Status { get; set; }
        public string Company { get; set; }
        public string IssueAge { get; set; }
        public decimal Amount { get; set; }
        public decimal Payment { get; set; }
        public DateTime? Dateplaced { get; set; }
        public bool Ownocc { get; set; }
        public string Class { get; set; }
        public string Oclass { get; set; }
        public string Risk { get; set; }
        public decimal Benper { get; set; }
        public decimal Elimper { get; set; }
        public bool Updat { get; set; }
        public decimal Cola { get; set; }
        public int Fiogib { get; set; }
        public int Rpr { get; set; }
        public string Comment { get; set; }
        public int Moamt { get; set; }
        public DateTime? Cmsnexport { get; set; }
        public decimal Cr8Grp { get; set; }
        public bool? Acc1 { get; set; }
        public bool? Acc0 { get; set; }
        public bool? Acc2 { get; set; }
        public string Callres { get; set; }
        public bool? SubPols { get; set; }
        public string Filename { get; set; }
        public decimal? Annprem { get; set; }
        public string PprNote { get; set; }
        public bool SvcAgt { get; set; }
        public string NoteCli { get; set; }
        public string NoteInt { get; set; }
        public string DivScale { get; set; }
        public DateTime? Reprojdate { get; set; }
        public bool Noprint { get; set; }
        public string Currency { get; set; }
        public string Id { get; set; }
        public decimal? CumDepact { get; set; }
        public string Benef { get; set; }
        public string Owner { get; set; }
        public string Insur { get; set; }
        public DateTime? AorStart { get; set; }
        public DateTime? AorEnd { get; set; }
        public string Status2 { get; set; }

        public virtual IEnumerable<Comm> Commissions { get; set; }
        public virtual ICollection<PolIll> PolIll { get; set; }
        public virtual ICollection<PolicyAgent> PolicyAgent { get; set; }
        public virtual ICollection<PeoplePolicys> PeoplePolicys { get; set; } = new List<PeoplePolicys>();
        public virtual ICollection<BusinessPolicys> BusinessPolicys { get; set; } = new List<BusinessPolicys>();
        public virtual ICollection<PeoplePolicys> PolicyAgents { get; set; } = new List<PeoplePolicys>();
    }
}
