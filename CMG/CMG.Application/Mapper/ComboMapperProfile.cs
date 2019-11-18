using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;

namespace CMG.Application.Mapper
{
    public class ComboMapperProfile : Profile
    {
        public ComboMapperProfile()
        {
            CreateMap<ViewComboDto, Combo>()
            .ForMember(des => des.FIELDNAME, mo => mo.MapFrom(src => src.FieldName.Trim()))
            .ForMember(des => des.FLDCODE, mo => mo.MapFrom(src => src.FieldCode))
            .ForMember(des => des.DESC_, mo => mo.MapFrom(src => src.Description))
            .ReverseMap();
        }
    }
}
