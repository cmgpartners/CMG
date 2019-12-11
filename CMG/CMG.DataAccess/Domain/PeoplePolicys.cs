using System;

namespace CMG.DataAccess.Domain
{
    public partial class PeoplePolicys : EntityBase
    {
        public int Keynuml { get; set; }
        public int Keynumo { get; set; }
        public string Catgry { get; set; }
        public bool Bus { get; set; }
        public string Hname { get; set; }
        public int Keynump { get; set; }
        public string Relatn { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public bool Del { get; set; }
        public decimal? Split { get; set; }
        public decimal Hsplit { get; set; }
        public string SalesforceId { get; set; }
        public string Emailc { get; set; }
        public string Dphonebusc { get; set; }
        public string Phonebusc { get; set; }
        public string Dphoneextc { get; set; }
        public bool? Islinked { get; set; }
        public string Hnamec { get; set; }

        public virtual People KeynumpNavigation { get; set; }
        public virtual Policys Policy { get; set; }
    }
}
