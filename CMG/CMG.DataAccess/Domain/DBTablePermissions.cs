using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Domain
{
    public class DBTablePermissions
    {
        public string Table_Qualifier { get; set; }
        public string Table_Owner { get; set; }
        public string Table_Name { get; set; }
        public string Grantor { get; set; }
        public string Grantee { get; set; }
        public string Privilege { get; set; }
        public string Is_Grantable { get; set; }
    }
}
