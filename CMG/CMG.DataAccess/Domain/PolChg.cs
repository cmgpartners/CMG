using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class PolChg
    {
        public int Keychgs { get; set; }
        public int Keynumo { get; set; }
        public DateTime EffDate { get; set; }
        public string Chgtype { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime RevDate { get; set; }
        public string RevLocn { get; set; }
        public bool Del { get; set; }
        public string Subject { get; set; }
        public string Det { get; set; }
        public int Keynump { get; set; }
        public string SalesforceId { get; set; }
        public string Policynum2 { get; set; }
    }
}
