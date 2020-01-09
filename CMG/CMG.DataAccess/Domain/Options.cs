using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace CMG.DataAccess.Domain
{
    public partial class Options : EntityBaseNew
    {
        [Key]
        public int Id { get; set; }

        public string Key { get; set; }

        public string Value { get; set; }

        public string User { get; set; }
    }
}
