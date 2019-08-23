using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Grp
    {
        public int Keynumg { get; set; }
        public string Grpnam { get; set; }
        public bool Public { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Cr8Locn { get; set; }
        public bool? Iscreator { get; set; }
        public bool Del { get; set; }
        public string Fldlist { get; set; }
    }
}
