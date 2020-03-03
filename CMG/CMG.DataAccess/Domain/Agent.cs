using System;
using System.Collections.Generic;

namespace CMG.DataAccess.Domain
{
    public partial class Agent : EntityBaseNew
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string AgentCode { get; set; }
        public string Color { get; set; }
        public bool IsExternal { get; set; }
        public int? Keynump { get; set; }
        public int? keynumb { get; set; }
    }
}
