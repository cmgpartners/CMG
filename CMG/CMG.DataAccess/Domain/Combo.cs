using System;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public class Combo : Entity
    {
        [Key]
        public int Id { get; set; }
        public string FIELDNAME { get; set; }
        public string FLDCODE { get; set; }
        public string DESC_ { get; set; }
        public DateTime Rev_Date { get; set; }
        public string Rev_Locn { get; set; }
    }
}
