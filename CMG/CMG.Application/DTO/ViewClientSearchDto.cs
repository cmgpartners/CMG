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
        public string Smoker { get; set; }
        public string ClientType { get; set; }
        public string Status { get; set; }
        public string SVCType { get; set; }
        public string GeneralNotes { get; set; }
        public string SalesforceId { get; set; }
    }
}
