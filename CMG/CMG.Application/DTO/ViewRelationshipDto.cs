using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewRelationshipDto
    {
        public int RelationshipId { get; set; }
        public int PeopleOrBusinessId { get; set; }
        public bool IsBusiness { get; set; }
        public int PolicyId { get; set; }
        public string Name { get; set; }
        public string Category { get; set; }
        public string Relation { get; set; }
        public decimal Split { get; set; }
        public bool IsDeleted { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
    }
}
