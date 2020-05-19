using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using System;
using System.Linq;

namespace CMG.Application.Mapper
{
    public class PolicyMapperProfile : Profile
    {
        public PolicyMapperProfile()
        {
            CreateMap<Policys, ViewPolicyListDto>()
                .ForMember(des => des.Id, mo => mo.MapFrom(src => src.Keynumo))
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum.Trim()))
                .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Company.Trim()))
                .ForMember(des => des.FaceAmount, mo => mo.MapFrom(src => src.Amount))
                .ForMember(des => des.Status, mo => mo.MapFrom(src => src.Status.Trim()))
                .ForMember(des => des.Frequency, mo => mo.MapFrom(src => src.Frequency.Trim()))
                .ForMember(des => des.Type, mo => mo.MapFrom(src => src.Type.Trim()))
                .ForMember(des => des.PlanCode, mo => mo.MapFrom(src => src.Plancode.Trim()))
                .ForMember(des => des.Rating, mo => mo.MapFrom(src => src.Risk.Trim()))
                .ForMember(des => des.Class, mo => mo.MapFrom(src => src.Class.Trim()))
                .ForMember(des => des.Currency, mo => mo.MapFrom(src => src.Currency.Trim()))
                .ForMember(des => des.PolicyDate, mo => mo.MapFrom(src => src.Issuedate))
                .ForMember(des => des.PlacedOn, mo => mo.MapFrom(src => src.Dateplaced))
                .ForMember(des => des.ReprojectedOn, mo => mo.MapFrom(src => src.Reprojdate))
                .ForMember(des => des.Age, mo => mo.MapFrom(src =>(src.IssueAge.All(char.IsDigit) && !string.IsNullOrEmpty(src.IssueAge.Trim())) ? Convert.ToInt32(src.IssueAge) : 0))
                .ForMember(des => des.PolicyNotes, mo => mo.MapFrom(src => src.Comment))
                .ForMember(des => des.ClientNotes, mo => mo.MapFrom(src => src.NoteCli))
                .ForMember(des => des.InternalNotes, mo => mo.MapFrom(src => src.NoteInt))
                .ForMember(des => des.Beneficiary, mo => mo.MapFrom(src => src.Benef))
                .ForMember(des => des.Owner, mo => mo.MapFrom(src => src.Owner))
                .ForMember(des => des.Insured, mo => mo.MapFrom(src => src.Insur))
                .ForMember(des => des.ModifiedDate, mo => mo.MapFrom(src => src.RevDate))
                .ForMember(des => des.ModifiedBy, mo => mo.MapFrom(src => src.RevLocn))
                .ForMember(des => des.CreatedDate, mo => mo.MapFrom(src => src.Cr8Date))
                .ForMember(des => des.CreatedBy, mo => mo.MapFrom(src => src.Cr8Locn))
                .AfterMap(AfterMapPolicysToRelationship);            

            CreateMap<ViewPolicyListDto, Policys>()
                .ForMember(des => des.Keynumo, mo => mo.MapFrom(src => src.Id))
                .ForMember(des => des.Policynum, mo => mo.MapFrom(src => src.PolicyNumber.Trim()))
                .ForMember(des => des.Company, mo => mo.MapFrom(src => src.CompanyName.Trim()))
                .ForMember(des => des.Amount, mo => mo.MapFrom(src => src.FaceAmount))
                .ForMember(des => des.Status, mo => mo.MapFrom(src => src.Status.Trim()))
                .ForMember(des => des.Frequency, mo => mo.MapFrom(src => src.Frequency.Trim()))
                .ForMember(des => des.Type, mo => mo.MapFrom(src => src.Type.Trim()))
                .ForMember(des => des.Plancode, mo => mo.MapFrom(src => src.PlanCode.Trim()))
                .ForMember(des => des.Risk, mo => mo.MapFrom(src => src.Rating.Trim()))
                .ForMember(des => des.Class, mo => mo.MapFrom(src => src.Class.Trim()))
                .ForMember(des => des.Currency, mo => mo.MapFrom(src => src.Currency.Trim()))
                .ForMember(des => des.Issuedate, mo => mo.MapFrom(src => src.PolicyDate))
                .ForMember(des => des.Dateplaced, mo => mo.MapFrom(src => src.PlacedOn))
                .ForMember(des => des.Reprojdate, mo => mo.MapFrom(src => src.ReprojectedOn))
                .ForMember(des => des.IssueAge, mo => mo.MapFrom(src => src.Age.ToString().Trim()))
                .ForMember(des => des.Comment, mo => mo.MapFrom(src => src.PolicyNotes))
                .ForMember(des => des.NoteCli, mo => mo.MapFrom(src => src.ClientNotes))
                .ForMember(des => des.NoteInt, mo => mo.MapFrom(src => src.InternalNotes))
                .ForMember(des => des.RevDate, mo => mo.MapFrom(src => src.ModifiedDate))
                .ForMember(des => des.RevLocn, mo => mo.MapFrom(src => src.ModifiedBy))
                .ForMember(des => des.Cr8Date, mo => mo.MapFrom(src => src.CreatedDate))
                .ForMember(des => des.Cr8Locn, mo => mo.MapFrom(src => src.CreatedBy));

            CreateMap<PeoplePolicys, ViewRelationshipDto>()
                .ForMember(des => des.RelationshipId, mo => mo.MapFrom(src => src.Keynuml))
                .ForMember(des => des.PeopleOrBusinessId, mo => mo.MapFrom(src => src.Keynump))
                .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
                .ForMember(des => des.IsBusiness, mo => mo.MapFrom(src => src.Bus))
                .ForMember(des => des.Name, mo => mo.MapFrom(src => src.Hname.Trim()))
                .ForMember(des => des.Category, mo => mo.MapFrom(src => src.Catgry.Trim()))
                .ForMember(des => des.Relation, mo => mo.MapFrom(src => src.Relatn.Trim()))
                .ForMember(des => des.People, mo => mo.MapFrom(src => src.People))
                .ForMember(des => des.IsDeleted, mo => mo.MapFrom(src => src.Del));

            CreateMap<BusinessPolicys, ViewRelationshipDto>()
                .ForMember(des => des.RelationshipId, mo => mo.MapFrom(src => src.Keynum))
                .ForMember(des => des.PeopleOrBusinessId, mo => mo.MapFrom(src => src.Keynumb))
                .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
                .ForMember(des => des.IsBusiness, mo => mo.MapFrom(src => src.Bus))
                .ForMember(des => des.Name, mo => mo.MapFrom(src => src.Hnamec.Trim()))
                .ForMember(des => des.Category, mo => mo.MapFrom(src => src.Catgry.Trim()))
                .ForMember(des => des.Relation, mo => mo.MapFrom(src => src.Relatn.Trim()))
                .ForMember(des => des.IsDeleted, mo => mo.MapFrom(src => src.Del));

            CreateMap<ViewRelationshipDto, BusinessPolicys>()
                .ForMember(des => des.Keynum, mo => mo.MapFrom(src => src.RelationshipId))
                .ForMember(des => des.Keynumb, mo => mo.MapFrom(src => src.PeopleOrBusinessId))
                .ForMember(des => des.Keynumo, mo => mo.MapFrom(src => src.PolicyId))
                .ForMember(des => des.Bus, mo => mo.MapFrom(src => src.IsBusiness))
                .ForMember(des => des.Hname, mo => mo.MapFrom(src => src.Name.Trim()))
                .ForMember(des => des.Catgry, mo => mo.MapFrom(src => src.Category.Trim()))
                .ForMember(des => des.Relatn, mo => mo.MapFrom(src => src.Relation.Trim()))
                .ForMember(des => des.Del, mo => mo.MapFrom(src => src.IsDeleted));

            CreateMap<ViewRelationshipDto, PeoplePolicys>()
                .ForMember(des => des.Keynuml, mo => mo.MapFrom(src => src.RelationshipId)) //Rishita
                .ForMember(des => des.Keynump, mo => mo.MapFrom(src => src.PeopleOrBusinessId))
                .ForMember(des => des.Keynumo, mo => mo.MapFrom(src => src.PolicyId))
                .ForMember(des => des.Bus, mo => mo.MapFrom(src => src.IsBusiness))
                .ForMember(des => des.Hname, mo => mo.MapFrom(src => src.Name.Trim()))
                .ForMember(des => des.Catgry, mo => mo.MapFrom(src => src.Category.Trim()))
                .ForMember(des => des.Relatn, mo => mo.MapFrom(src => src.Relation.Trim()))
                .ForMember(des => des.Del, mo => mo.MapFrom(src => src.IsDeleted));

            CreateMap<Policys, ViewPolicyDto>()
               .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
               .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum))
               .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Company))
               .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => src.Insur));

            CreateMap<PolicyAgent, ViewCommissionAgentDto>()
              .ForMember(des => des.Split, mo => mo.MapFrom(src => src.Split.HasValue ? (decimal)src.Split.Value : 0))
              .ReverseMap();

            CreateMap<ViewPolicyDto, ViewCommissionDto>()
             .ForMember(des => des.AgentCommissions, mo => mo.MapFrom(src => src.CommissionAgents));

            CreateMap<ViewCommissionAgentDto, ViewAgentCommissionDto>()
            .ForMember(des => des.Id, mo => mo.Ignore());           
        }
        private void AfterMapPolicysToRelationship(Policys src, ViewPolicyListDto des)
        {
            if (src.PeoplePolicys != null
                && src.BusinessPolicys != null)
            {
                int totalCount = src.PeoplePolicys.Count + src.BusinessPolicys.Count;
                int a = 0;
                for (int i = 0; i < src.PeoplePolicys.Count; i++)
                {
                    des.Relationships.Add(new ViewRelationshipDto());
                    des.Relationships.ElementAt(i).RelationshipId = src.PeoplePolicys.ElementAt(i).Keynuml;
                    des.Relationships.ElementAt(i).PeopleOrBusinessId = src.PeoplePolicys.ElementAt(i).Keynump;
                    des.Relationships.ElementAt(i).PolicyId = src.PeoplePolicys.ElementAt(i).Keynumo;
                    des.Relationships.ElementAt(i).IsBusiness = src.PeoplePolicys.ElementAt(i).Bus;
                    des.Relationships.ElementAt(i).Name = src.PeoplePolicys.ElementAt(i).Hname.Trim();
                    des.Relationships.ElementAt(i).Category = src.PeoplePolicys.ElementAt(i).Catgry.Trim();
                    des.Relationships.ElementAt(i).Relation = src.PeoplePolicys.ElementAt(i).Relatn.Trim();
                    des.Relationships.ElementAt(i).IsDeleted = src.PeoplePolicys.ElementAt(i).Del;
                }
                for (int i = src.PeoplePolicys.Count; i < totalCount; i++)
                {
                    des.Relationships.Add(new ViewRelationshipDto());
                    des.Relationships.ElementAt(i).RelationshipId = src.BusinessPolicys.ElementAt(a).Keynum;
                    des.Relationships.ElementAt(i).PeopleOrBusinessId = src.BusinessPolicys.ElementAt(a).Keynumb;
                    des.Relationships.ElementAt(i).PolicyId = src.BusinessPolicys.ElementAt(a).Keynumo;
                    des.Relationships.ElementAt(i).IsBusiness = src.BusinessPolicys.ElementAt(a).Bus;
                    des.Relationships.ElementAt(i).Name = src.BusinessPolicys.ElementAt(a).Hname.Trim();
                    des.Relationships.ElementAt(i).Category = src.BusinessPolicys.ElementAt(a).Catgry.Trim();
                    des.Relationships.ElementAt(i).Relation = src.BusinessPolicys.ElementAt(a).Relatn.Trim();
                    des.Relationships.ElementAt(i).IsDeleted = src.BusinessPolicys.ElementAt(a).Del;
                    a++;
                }
            }
        }
    }
}
