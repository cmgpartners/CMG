using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
namespace CMG.Application.Mapper
{
    public class CaseMapperProfile : Profile
    {
        public CaseMapperProfile()
        {
            CreateMap<Cases, ViewCasesDto>()
                .ForMember(des => des.CaseId, src => src.MapFrom(src => src.Keycase))
                .ForMember(des => des.PeopleId, src => src.MapFrom(src => src.Keynump))
                .ForMember(des => des.TargetDate, src => src.MapFrom(src => src.Tdate))
                .ForMember(des => des.DiscoveryStartAmount, src => src.MapFrom(src => src.Case1))
                .ForMember(des => des.DiscoveryEndAmount, src => src.MapFrom(src => src.Case2))
                .ForMember(des => des.DesignStartAmount, src => src.MapFrom(src => src.Case3))
                .ForMember(des => des.DesignEndAmount, src => src.MapFrom(src => src.Case4))
                .ForMember(des => des.DeliveryStartAmount, src => src.MapFrom(src => src.Case5))
                .ForMember(des => des.DeliveryEndAmount, src => src.MapFrom(src => src.Case6))
                .ForMember(des => des.DestinyStartAmount, src => src.MapFrom(src => src.Case7))
                .ForMember(des => des.DestinyEndAmount, src => src.MapFrom(src => src.Case8))
                .ForMember(des => des.DiscoveryStartDate, src => src.MapFrom(src => src.Case1d))
                .ForMember(des => des.DiscoveryEndDate, src => src.MapFrom(src => src.Case2d))
                .ForMember(des => des.DesignStartDate, src => src.MapFrom(src => src.Case3d))
                .ForMember(des => des.DesignEndDate, src => src.MapFrom(src => src.Case4d))
                .ForMember(des => des.DeliveryStartDate, src => src.MapFrom(src => src.Case5d))
                .ForMember(des => des.DeliveryEndDate, src => src.MapFrom(src => src.Case6d))
                .ForMember(des => des.DestinyStartDate, src => src.MapFrom(src => src.Case7d))
                .ForMember(des => des.DestinyEndDate, src => src.MapFrom(src => src.Case8d))
                .ForMember(des => des.IsDiscoveryStart, src => src.MapFrom(src => src.Casey1))
                .ForMember(des => des.IsDiscoveryEnd, src => src.MapFrom(src => src.Casey2))
                .ForMember(des => des.IsDesignStart, src => src.MapFrom(src => src.Casey3))
                .ForMember(des => des.IsDesignEnd, src => src.MapFrom(src => src.Casey4))
                .ForMember(des => des.IsDeliveryStart, src => src.MapFrom(src => src.Casey5))
                .ForMember(des => des.IsDeliveryEnd, src => src.MapFrom(src => src.Casey6))
                .ForMember(des => des.IsDestinyStart, src => src.MapFrom(src => src.Casey7))
                .ForMember(des => des.IsDestinyEnd, src => src.MapFrom(src => src.Casey8))
                .ForMember(des => des.ModifiedBy, src => src.MapFrom(src => src.RevLocn))
                .ReverseMap()
                ;

            CreateMap<CaseAgent, ViewCaseAgentDto>();
        }
    }
}
