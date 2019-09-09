using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using System;

namespace CMG.Application.Mapper
{
    public class AgentMapperProfile : Profile
    {
        public AgentMapperProfile()
        {
            CreateMap<ViewAgentDto, Agent>()
            .AfterMap(AfterMapAgentInfo)
            .ForMember(des => des.ModifiedBy, mo => mo.MapFrom(src => src.CurrentUser.Trim()))
            .ForMember(des => des.ModifiedDate, mo => mo.MapFrom(src => DateTime.Now))
            .ReverseMap();
        }
       
        private void AfterMapAgentInfo(ViewAgentDto source, Agent des)
        {
            if(!string.IsNullOrWhiteSpace(source.FirstName)
               && !string.IsNullOrWhiteSpace(source.MiddleName)
               && !string.IsNullOrWhiteSpace(source.LastName))
            {
                des.AgentCode = source.FirstName.Substring(0, 1) + source.MiddleName.Substring(0, 1) + source.LastName.Substring(0, 1);
            }

            if(!source.Id.HasValue)
            {
                des.CreatedDate = DateTime.Now;
                des.CreatedBy = source.CurrentUser.Trim();
            }
        }
    }
}
