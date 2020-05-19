using AutoMapper;
using CMG.DataAccess.Domain;
using CMG.Application.DTO;

namespace CMG.Application.Mapper
{
    public class PeopleMapperProfile : Profile
    {
        public PeopleMapperProfile()
        {
            CreateMap<People, ViewPeopleDto>()
                .ForMember(des => des.PeopleId, src => src.MapFrom(src => src.Keynump))
                .ForMember(des => des.CommanName, src => src.MapFrom(src => src.Commname.Trim()))
                .ForMember(des => des.MiddleName, src => src.MapFrom(src => src.Midname))
                .ForMember(des => des.ServiceType, src => src.MapFrom(src => src.SvcType))
                .ForMember(des => des.Status, src => src.MapFrom(src => src.Pstatus))
                .ForMember(des => des.ClientType, src => src.MapFrom(src => src.Clienttyp))
                .ForMember(des => des.PhotoPath, src => src.MapFrom(src => src.Picpath))
                .ForMember(des => des.DirectBussinesPhone, src => src.MapFrom(src => src.Dphonebus))
                .ForMember(des => des.CellPhone, src => src.MapFrom(src => src.Phonecar))
                .ForMember(des => des.Initials, src => src.MapFrom(src => src.Initials))
                .ForMember(des => des.BusinessRelations, src => src.MapFrom(src => src.RelBp))
                .ForMember(des => des.PeopleRelations, src => src.MapFrom(src => src.RelPpKeynumpNavigation))
                .ForMember(des => des.PeoplePolicies, src => src.MapFrom(src => src.PeoplePolicys))
                ;
            CreateMap<RelBp, ViewRelBPDto>()
                .ForMember(des => des.Business, src => src.MapFrom(src => src.KeynumbNavigation))
                .ForMember(des => des.IsPrimary, src => src.MapFrom(src => src.Primary));

            CreateMap<RelPp, ViewRelPPDto>()
                .ForMember(des => des.People, src => src.MapFrom(src => src.Keynump2Navigation))
                .ForMember(des => des.RelatedPeople, src => src.MapFrom(src => src.KeynumpNavigation))
                .ForMember(des => des.RelationCode, src => src.MapFrom(src => src.RelCode))
                .ForMember(des => des.RelationGroup, src => src.MapFrom(src => src.RelGrp));
        }
    }
}
