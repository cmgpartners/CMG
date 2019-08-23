using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Grpitem
    {
        public int Keynumi { get; set; }
        public int Keynumg { get; set; }
        public bool Bus { get; set; }
        public int Keynumbp { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Cr8Locn { get; set; }
        public bool Del { get; set; }
    }
}
