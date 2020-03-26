using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class People : EntityBase
    {
        public People()
        {
            PeoplePolicys = new HashSet<PeoplePolicys>();
            RelBp = new HashSet<RelBp>();
            RelPpKeynump2Navigation = new HashSet<RelPp>();
            RelPpKeynumpNavigation = new HashSet<RelPp>();
            Cases = new HashSet<Cases>();
        }

        public int Keynump { get; set; }
        public string MrMrs { get; set; }
        public string Firstname { get; set; }
        public string Midname { get; set; }
        public decimal Givenname { get; set; }
        public string Salute { get; set; }
        public string Lastname { get; set; }
        public string Maidname { get; set; }
        public DateTime? Birthdate { get; set; }
        public string Sex { get; set; }
        public string Agent1 { get; set; }
        public string Agent2 { get; set; }
        public string Agent3 { get; set; }
        public string Agent4 { get; set; }
        public string Agent5 { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string Prov { get; set; }
        public string Postalcode { get; set; }
        public string Sin { get; set; }
        public string Secretary { get; set; }
        public string Recept { get; set; }
        public string SecExt { get; set; }
        public string Phonehom { get; set; }
        public string Phonecar { get; set; }
        public string Dphonefax { get; set; }
        public string Dphonebus { get; set; }
        public string Phoneoth { get; set; }
        public string Othtype { get; set; }
        public string Smoker { get; set; }
        public string Occupation { get; set; }
        public string Clienttyp { get; set; }
        public string Pstatus { get; set; }
        public string Source { get; set; }
        public string Email { get; set; }
        public string Email2 { get; set; }
        public string Etype2 { get; set; }
        public string Gnotes { get; set; }
        public string Brnote { get; set; }
        public string Clientdir { get; set; }
        public string Picpath { get; set; }
        public decimal CaseStage { get; set; }
        public decimal Networth { get; set; }
        public string Srccat { get; set; }
        public DateTime? Tdate { get; set; }
        public string Cnotes { get; set; }
        public DateTime? Weddate { get; set; }
        public bool Haddr { get; set; }
        public byte Score1 { get; set; }
        public byte Score2 { get; set; }
        public byte Score3 { get; set; }
        public byte Score4 { get; set; }
        public byte Score5 { get; set; }
        public byte Score6 { get; set; }
        public byte Score7 { get; set; }
        public byte Score8 { get; set; }
        public byte Score9 { get; set; }
        public byte Score10 { get; set; }
        public string Kolbe { get; set; }
        public int Casenew { get; set; }
        public string Religion { get; set; }
        public string Fcdfp { get; set; }
        public string Fcdfrb { get; set; }
        public string Fcdes { get; set; }
        public string Fcdffp { get; set; }
        public string Fcdvs { get; set; }
        public string Fcdbl { get; set; }
        public string Fcdfl { get; set; }
        public string Pin { get; set; }
        public DateTime? SvcDate { get; set; }
        public DateTime? DecDate { get; set; }
        public string Caseagent1 { get; set; }
        public string Pnotes { get; set; }
        public string Fcdws { get; set; }
        public string Fcdsa { get; set; }
        public string Fcdtr { get; set; }
        public string Market { get; set; }
        public string Initials { get; set; }
        public string Thirdname { get; set; }
        public string SvcType { get; set; }
        public string SalesforceId { get; set; }
        public string Fullname { get; set; }
        public string Commname { get; set; }
        public int? Keyasst { get; set; }
        public string Spouse { get; set; }
        public decimal? Annprem { get; set; }

        public virtual ICollection<PeoplePolicys> PeoplePolicys { get; set; }
        public virtual ICollection<RelBp> RelBp { get; set; }
        public virtual IEnumerable<RelPp> RelPpKeynump2Navigation { get; set; }
        public virtual IEnumerable<RelPp> RelPpKeynumpNavigation { get; set; }
        public virtual IEnumerable<Cases> Cases { get; set; }
    }
}
