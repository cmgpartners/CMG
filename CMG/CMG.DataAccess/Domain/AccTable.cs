using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class AccTable
    {
        public string UserName { get; set; }
        public decimal OrgGrp { get; set; }
        public int Keynump { get; set; }
        public string Bcc { get; set; }
        public string IdAcct { get; set; }
        public string IdUser { get; set; }
    }
}
