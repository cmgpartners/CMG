using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewFileManagerDto
    {
        public string Name { get; set; }
        public string Type { get; set; }
        public string Size { get; set; }
        public DateTime ModifiedOn { get; set; }
    }
}
