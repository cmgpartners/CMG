using System.Collections.Generic;

namespace CMG.Application.DTO
{
    public class ViewPeopleDto 
    {
        public int PeopleId { get; set; }
        public string FirstName { get; set; }
        public string CommanName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public string PhotoPath { get; set; }
        public string DirectPhoneBus { get; set; }
        public string ClientType { get; set; }
        public string  Status { get; set; }
        public string ServiceType { get; set; }
        public ICollection<ViewRelBPDto> BusinessRelations { get; set; }
        public ICollection<ViewCasesDto> Cases { get; set; }
        public ICollection<ViewRelPPDto> PeopleRelations { get; set; }
        public ICollection<ViewRelationshipDto> PeoplePolicies { get; set; }
        public ViewBusinessDto PrimaryBusiness { get; set; }
        public decimal TotalFaceAmount { get; set; }
        public decimal TotalPremiumAmount { get; set; }
        public string FullName 
        {
            get
            {
                return $"{LastName.Trim()}, {CommanName.Trim()}";
            }
        }
        public ICollection<ViewRelPPDto> Family { get; set; }
        public ICollection<ViewRelPPDto> KeyAdvisors { get; set; }
    }
}
