using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class PeoCall
    {
        public int Keycp { get; set; }
        public int Keynump { get; set; }
        public int Keycall { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public bool Del { get; set; }
        public byte Bus { get; set; }
        public string SalesforceId { get; set; }
        public string CallRole { get; set; }
    }
}
