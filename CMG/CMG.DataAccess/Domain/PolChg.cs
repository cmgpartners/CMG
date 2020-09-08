﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CMG.DataAccess.Domain
{
    public partial class PolChg : EntityBase
    {
        [Key]
        public int Keychgs { get; set; }
        public int Keynumo { get; set; }
        public DateTime EffDate { get; set; }
        public string Chgtype { get; set; }
        public string Subject { get; set; }
        public string Det { get; set; }
        public int Keynump { get; set; }
        public string SalesforceId { get; set; }
        public string Policynum2 { get; set; }
    }
}
