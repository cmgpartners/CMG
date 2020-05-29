using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewReportMenuDTO
    {
        public string Menu { get; set; }
        public List<ViewReportMenuDTO> Submenu { get; set; } = new List<ViewReportMenuDTO>();
        public bool IsSeparator { get; set; }
    }
}
