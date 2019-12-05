using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewClientSearchDto
    {
        public int Keynump { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string CommonName { get; set; }
        public Nullable<DateTime> BirthDate { get; set; }
        public bool IsSmoker { get; set; }
        public string ClientType { get; set; }
    }
}
