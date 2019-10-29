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
               .ReverseMap();

            CreateMap<ViewAgentWithdrawalDto, AgentWithdrawal>()
                .ReverseMap();

        }
    }
}
