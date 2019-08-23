using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Todo
    {
        public int Keytodo { get; set; }
        public string Subj { get; set; }
        public string Detail { get; set; }
        public DateTime? Duedate { get; set; }
        public DateTime? Compdate { get; set; }
        public int Respkey { get; set; }
        public int Cr8key { get; set; }
        public string Tstatus { get; set; }
        public int Keynumo { get; set; }
        public int Keycall { get; set; }
        public int Keynump { get; set; }
        public bool Private { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime? Cr8Date { get; set; }
        public bool Del { get; set; }
        public string Priority { get; set; }
        public string Tasktype { get; set; }
        public string SalesforceId { get; set; }
        public string Clientname { get; set; }
    }
}
