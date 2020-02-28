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
        }
    }
}
