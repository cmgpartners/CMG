using AutoMapper;
using CMG.DataAccess.Domain;
using CMG.Application.DTO;

namespace CMG.Application.Mapper
{
    public class BusinessRelationMapperProfile : Profile
    {
        public BusinessRelationMapperProfile()
        {
            CreateMap<Business, ViewBusinessRelationDto>()
                .ForMember(des => des.BusinessName, src => src.MapFrom(src => src.Busname.Trim()))
                .ForMember(des => des.Address, src => src.MapFrom(src => src.Bstreet.Trim()));

            CreateMap<Business, ViewBusinessDto>()
                .ForMember(des => des.BusinessName, src => src.MapFrom(src => src.Busname.Trim()))
                .ForMember(des => des.BusinessPhone, src => src.MapFrom(src => src.Phonebus.Trim()))
                .ForMember(des => des.StreetName, src => src.MapFrom(src => src.Bstreet.Trim()))
                .ForMember(des => des.City, src => src.MapFrom(src => src.Bcity.Trim()))
                .ForMember(des => des.Province, src => src.MapFrom(src => src.Bprov.Trim()))
                .ForMember(des => des.PostalCode, src => src.MapFrom(src => src.Bpostalcod.Trim()));

            CreateMap<ViewBusinessRelationDto, BusinessPolicys>();
        }
    }
}
