using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.Mapper
{
    public class WithdrawalMapperProfile : Profile
    {
        public WithdrawalMapperProfile()
        {

            CreateMap<ViewWithdrawalDto, Withd>()
               .ForMember(des => des.Keywith, mo => mo.MapFrom(src => src.WithdrawalId))
               .ForMember(des => des.AgentWithdrawal, mo => mo.MapFrom(src => src.AgentWithdrawals))
               .ForMember(des => des.Cr8Date, mo => mo.MapFrom(src => src.CreatedDate))
               .ForMember(des => des.Cr8Locn, mo => mo.MapFrom(src => src.CreatedBy))
               .ForMember(des => des.Del, mo => mo.MapFrom(src => src.IsDeleted))
               .ForMember(des => des.RevDate, mo => mo.MapFrom(src => src.ModifiedDate))
               .ForMember(des => des.RevLocn, mo => mo.MapFrom(src => src.ModifiedBy))
               .ReverseMap();

            CreateMap<ViewAgentWithdrawalDto, AgentWithdrawal>()
                .ReverseMap();

        }
    }
}
