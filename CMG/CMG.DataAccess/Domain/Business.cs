using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Business
    {
        public Business()
        {
            BusinessPolicys = new HashSet<BusinessPolicys>();
            RelBp = new HashSet<RelBp>();
        }

        public int Keynumb { get; set; }
        public string Busname { get; set; }
        public string Parname { get; set; }
        public string Bstreet { get; set; }
        public string Bcity { get; set; }
        public string Bprov { get; set; }
        public string Bpostalcod { get; set; }
        public string Phonebus { get; set; }
        public string Phonefax { get; set; }
        public string Bphoneoth { get; set; }
        public string Bothtype { get; set; }
        public string ProdType { get; set; }
        public string Sic1 { get; set; }
        public string Sic2 { get; set; }
        public string Sic3 { get; set; }
        public string Sic4 { get; set; }
        public string Dunsno { get; set; }
        public string Bnotes { get; set; }
        public bool Bforeign { get; set; }
        public bool Bpublic { get; set; }
        public string Clientdir { get; set; }
        public string Yearend { get; set; }
        public decimal Fyear { get; set; }
        public decimal Fyear2 { get; set; }
        public decimal Fyear3 { get; set; }
        public decimal Fyear4 { get; set; }
        public decimal Fyear5 { get; set; }
        public decimal Annsales { get; set; }
        public decimal Annsales2 { get; set; }
        public decimal Annsales3 { get; set; }
        public decimal Annsales4 { get; set; }
        public decimal Annsales5 { get; set; }
        public int NumEmpl { get; set; }
        public int NumEmpl2 { get; set; }
        public int NumEmpl3 { get; set; }
        public int NumEmpl4 { get; set; }
        public int NumEmpl5 { get; set; }
        public decimal Annprofit { get; set; }
        public decimal Annprofit2 { get; set; }
        public decimal Annprofit3 { get; set; }
        public decimal Annprofit4 { get; set; }
        public decimal Annprofit5 { get; set; }
        public decimal Marketval { get; set; }
        public decimal Marketval2 { get; set; }
        public decimal Marketval3 { get; set; }
        public decimal Marketval4 { get; set; }
        public decimal Marketval5 { get; set; }
        public decimal Bookval { get; set; }
        public decimal Bookval2 { get; set; }
        public decimal Bookval3 { get; set; }
        public decimal Bookval4 { get; set; }
        public decimal Bookval5 { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Website { get; set; }
        public bool Del { get; set; }
        public string Mapid { get; set; }
        public short SummPolc { get; set; }
        public string SalesforceId { get; set; }

        public virtual ICollection<BusinessPolicys> BusinessPolicys { get; set; }
        public virtual ICollection<RelBp> RelBp { get; set; }
    }
}
