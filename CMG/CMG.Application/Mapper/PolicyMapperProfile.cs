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
                .ForMember(des => des.PolicyId, mo => mo.MapFrom(src => src.Keynumo))
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum));
        }
    }
}
