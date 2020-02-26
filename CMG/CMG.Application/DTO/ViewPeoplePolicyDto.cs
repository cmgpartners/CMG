using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewPeoplePolicyDto
    {
        public int PeopleId { get; set; }
        public int PolicyId { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public string Relation { get; set; }
        public decimal Split { get; set; }
        public ViewAgentDto Agent { get; set; }
    }
}
