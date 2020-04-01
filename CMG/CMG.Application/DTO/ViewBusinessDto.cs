using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewBusinessDto
    {
        public string BusinessName { get; set; }
        public string BusinessPhone { get; set; }
        public string StreetName { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string PostalCode { get; set; }
        public string Address 
        { 
            get
            {
                var address = new[] { StreetName, City, Province, PostalCode };
                return string.Join(", ", address.Where(s => !string.IsNullOrEmpty(s)));
            }
        }
    }
}
