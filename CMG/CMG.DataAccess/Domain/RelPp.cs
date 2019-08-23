using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class RelPp
    {
        public int Keynumr { get; set; }
        public int Keynump { get; set; }
        public string RelCode { get; set; }
        public int Keynump2 { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public string RelGrp { get; set; }
        public bool Del { get; set; }
        public string Reason { get; set; }
        public DateTime? StatDate { get; set; }
        public string Details { get; set; }
        public string Magicthred { get; set; }
        public string Others { get; set; }
        public string Relation { get; set; }
        public string Tmqual { get; set; }
        public string Connectn { get; set; }
        public DateTime? StatDate2 { get; set; }
        public string Leader { get; set; }
        public string SalesforceId { get; set; }
    }
}
