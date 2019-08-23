using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Calls
    {
        public int Keycall { get; set; }
        public int Keynump { get; set; }
        public DateTime? Calldate { get; set; }
        public DateTime? Calldate2 { get; set; }
        public string Caller { get; set; }
        public string Calltype { get; set; }
        public string Subject { get; set; }
        public string To { get; set; }
        public string Salutation { get; set; }
        public string Details { get; set; }
        public string Details2 { get; set; }
        public string Writer { get; set; }
        public string Comments { get; set; }
        public string RevLocn { get; set; }
        public DateTime RevDate { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime Cr8Date { get; set; }
        public string Callgrp { get; set; }
        public string Callres { get; set; }
        public bool Del { get; set; }
        public string Messageid { get; set; }
        public int SummTodo { get; set; }
        public string SalesforceId { get; set; }
        public string Tstatus { get; set; }
        public string Priority { get; set; }
        public string Fullname { get; set; }
    }
}
