using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Withd
    {
        public int Keywith { get; set; }
        public string Dtype { get; set; }
        public string Yrmo { get; set; }
        public string Desc { get; set; }
        public string Ctype { get; set; }
        public decimal Marty { get; set; }
        public decimal Peter { get; set; }
        public decimal Frank { get; set; }
        public decimal Bob { get; set; }
        public decimal Mary { get; set; }
        public decimal Other { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public bool Del { get; set; }
    }
}
