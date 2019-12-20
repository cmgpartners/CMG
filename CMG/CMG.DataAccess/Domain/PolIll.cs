using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class PolIll : EntityBase
    {
        public int Keynumo { get; set; }
        public byte? Year { get; set; }
        public decimal Cv { get; set; }
        public decimal Db { get; set; }
        public decimal Cvact { get; set; }
        public decimal Dbact { get; set; }
        public decimal Cvre { get; set; }
        public decimal Dbre { get; set; }
        public decimal Anndep { get; set; }
        public decimal Acb { get; set; }
        public string Display { get; set; }
        public decimal Ncpi { get; set; }
        public decimal Incpay { get; set; }
        public decimal Lifepay { get; set; }
        public decimal Anndepre { get; set; }
        public decimal Anndepact { get; set; }
        public decimal Acbact { get; set; }
        public decimal Acbre { get; set; }
        public decimal Ncpiact { get; set; }
        public decimal Ncpire { get; set; }
        public int? KeyIll { get; set; }
        public byte Divscale { get; set; }
        public short? Yearcal { get; set; }
        [Key]
        public int Id { get; set; }

        public virtual Policys KeynumoNavigation { get; set; }
    }
}
