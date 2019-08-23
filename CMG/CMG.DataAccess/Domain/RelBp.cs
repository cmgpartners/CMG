using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class RelBp
    {
        public int Keyrelb { get; set; }
        public int Keynump { get; set; }
        public string TitleOcc { get; set; }
        public bool Primary { get; set; }
        public decimal PcntOwner { get; set; }
        public string Dphoneext { get; set; }
        public string Ophoneext { get; set; }
        public int Keynumb { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public bool Del { get; set; }
        public string SalesforceId { get; set; }
    }
}
