using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;

namespace CMG.Application.Mapper
{
    public class PolicyMapperProfile : Profile
    {
        public PolicyMapperProfile()
        {
            CreateMap<Policys, ViewPolicyListDto>()
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum));

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
