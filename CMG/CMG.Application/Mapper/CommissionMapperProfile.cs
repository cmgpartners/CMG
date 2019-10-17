using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using System;

namespace CMG.Application.Mapper
{
    public class CommissionMapperProfile : Profile
    {
        public CommissionMapperProfile()
        {

            CreateMap<ViewCommissionDto, Comm>()
               .ForMember(des => des.Keycomm, mo => mo.MapFrom(src => src.CommissionId))
               .ForMember(des => des.Keynumo, mo => mo.MapFrom(src => src.PolicyId))
               .ForMember(des => des.Policynum, mo => mo.MapFrom(src => src.PolicyNumber))
               .ForMember(des => des.Company, mo => mo.MapFrom(src => src.CompanyName))
               .ForMember(des => des.Insured, mo => mo.MapFrom(src => src.InsuredName))
               .ForMember(des => des.Renewals, mo => mo.MapFrom(src => src.Renewal))
               .ForMember(des => des.Total, mo => mo.MapFrom(src => src.TotalAmount))
               .ForMember(des => des.Commtype, mo => mo.MapFrom(src => src.CommissionType))
               .ForMember(des => des.Yrmo, mo => mo.MapFrom(src => src.YearMonth))
               .ForMember(des => des.Cr8Date, mo => mo.MapFrom(src => src.CreatedDate))
               .ForMember(des => des.Cr8Locn, mo => mo.MapFrom(src => src.CreatedBy))
               .ForMember(des => des.Del, mo => mo.MapFrom(src => src.IsDeleted))
               .ForMember(des => des.AgentCommissions, mo => mo.MapFrom(src => src.AgentCommissions))
               .ReverseMap();
                
            CreateMap<AgentCommission, ViewAgentCommissionDto>()
                .ForMember(des => des.Commission, mo => mo.MapFrom(src => src.Commission.HasValue ? (decimal)src.Commission.Value : 0))
                .ForMember(des => des.Split, mo => mo.MapFrom(src => src.Split.HasValue ? (decimal)src.Split.Value : 0))
                .ForMember(des => des.CreatedBy, mo => mo.MapFrom(src => src.CreatedBy))
                .ForMember(des => des.CreatedDate, mo => mo.MapFrom(src => src.CreatedDate))
                .ForMember(des => des.IsDeleted, mo => mo.MapFrom(src => src.IsDeleted))
                .ReverseMap();
        }
    }
}
