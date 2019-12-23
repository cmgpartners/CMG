using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using System;

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
                .ForMember(des => des.Payment, mo => mo.MapFrom(src => src.Payment))
                .ForMember(des => des.Status, mo => mo.MapFrom(src => src.Status.Trim()))
                .ForMember(des => des.Frequency, mo => mo.MapFrom(src => src.Frequency.Trim()))
                .ForMember(des => des.Type, mo => mo.MapFrom(src => src.Type.Trim()))
                .ForMember(des => des.PlanCode, mo => mo.MapFrom(src => src.Plancode.Trim()))
                .ForMember(des => des.Rating, mo => mo.MapFrom(src => src.Risk))
                .ForMember(des => des.Class, mo => mo.MapFrom(src => src.Class.Trim()))
                .ForMember(des => des.Currency, mo => mo.MapFrom(src => src.Currency.Trim()))
                .ForMember(des => des.PolicyDate, mo => mo.MapFrom(src => src.Issuedate))
                .ForMember(des => des.PlacedOn, mo => mo.MapFrom(src => src.Cr8Date))
                .ForMember(des => des.ReprojectedOn, mo => mo.MapFrom(src => src.Reprojdate))
                .ForMember(des => des.Age, mo => mo.MapFrom(src => !string.IsNullOrEmpty(src.IssueAge.Trim()) ? Convert.ToInt32(src.IssueAge) : 0))
                .ForMember(des => des.PolicyNotes, mo => mo.MapFrom(src => src.Comment))
                .ForMember(des => des.ClientNotes, mo => mo.MapFrom(src => src.NoteCli))
                .ForMember(des => des.InternalNotes, mo => mo.MapFrom(src => src.NoteInt))
                .ForMember(des => des.PeoplePolicy, mo => mo.MapFrom(src => src.PeoplePolicys))
                .ReverseMap();

            CreateMap<PeoplePolicys, ViewPeoplePolicyDto>()
                .ForMember(des => des.PeopleId, mo => mo.MapFrom(src => src.Keynump))
                .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
                .ForMember(des => des.Name, mo => mo.MapFrom(src => src.Hname.Trim()))
                .ForMember(des => des.Category, mo => mo.MapFrom(src => src.Catgry.Trim()))
                .ForMember(des => des.Relation, mo => mo.MapFrom(src => src.Relatn.Trim()));

            CreateMap<Policys, ViewPolicyDto>()
               .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
               .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum))
               .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Company))
               .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => src.Insur))
               .ForMember(des => des.PolicyAgents, mo => mo.MapFrom(src => src.PolicyAgent));

            CreateMap<PolicyAgent, ViewPolicyAgentDto>()
              .ForMember(des => des.Split, mo => mo.MapFrom(src => src.Split.HasValue ? (decimal)src.Split.Value : 0))
              .ReverseMap();

            CreateMap<ViewPolicyDto, ViewCommissionDto>()
             .ForMember(des => des.AgentCommissions, mo => mo.MapFrom(src => src.PolicyAgents));

            CreateMap<ViewPolicyAgentDto, ViewAgentCommissionDto>()
            .ForMember(des => des.Id, mo => mo.Ignore());           
        }
    }
}
