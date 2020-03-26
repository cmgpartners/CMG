using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewRelPPDto
    {
        public string RelationCode { get; set; }
        public string RelationGroup { get; set; }
        public ViewPeopleDto RelatedPeople { get; set; }
        public ViewPeopleDto People { get; set; }
        public string RelationDescription { get; set; }
    }
}
