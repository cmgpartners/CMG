using AutoMapper;
using CMG.DataAccess.Domain;
using CMG.Application.DTO;

namespace CMG.Application.Mapper
{
    public class ClientSearchProfiler : Profile
    {
        public ClientSearchProfiler()
        {
            CreateMap<People, ViewClientSearchDto>()
                .ForMember(des => des.FirstName, src => src.MapFrom(src => src.Firstname.Trim()))
                .ForMember(des => des.LastName, src => src.MapFrom(src => src.Lastname.Trim()))
                .ForMember(des => des.CommonName, src => src.MapFrom(src => src.Commname.Trim()))
                .ForMember(des => des.ClientType, src => src.MapFrom(src => src.Clienttyp.Trim()))
                .ForMember(des => des.IsSmoker, src => src.MapFrom(src => src.Smoker.ToString().Trim() == "Y" ? true : false));
        }
    }
}
