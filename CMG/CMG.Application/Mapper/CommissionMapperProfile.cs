using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;

namespace CMG.Application.Mapper
{
    public class CommissionMapperProfile : Profile
    {
        public CommissionMapperProfile()
        {
            CreateMap<Comm, ViewCommissionDto>()
                .ForMember(des => des.CommissionId, mo => mo.MapFrom(src => src.Keycomm))
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policy.Policynum))
                .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Policy.Company))
                .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => src.Insured))
                .ForMember(des => des.Renewal, mo => mo.MapFrom(src => src.Renewals))
                .ForMember(des => des.TotalAmount, mo => mo.MapFrom(src => src.Total))
                .ForMember(des => des.AgentCommissions, mo => mo.MapFrom(src => src.AgentCommissions))
                .ReverseMap();

            CreateMap<ViewCommissionDto, Comm>()
                .ForMember(des => des.Cr8Date, mo => mo.MapFrom(src => System.DateTime.Now))
                .ForMember(des => des.RevDate, mo => mo.MapFrom(src => System.DateTime.Now));

            CreateMap<AgentCommission, ViewAgentCommissionDto>()
                .ForMember(des => des.Commission, mo => mo.MapFrom(src => src.Commission.HasValue ? (decimal)src.Commission.Value : 0))
                .ForMember(des => des.Split, mo => mo.MapFrom(src => src.Split.HasValue ? (decimal)src.Split.Value : 0))
                .ReverseMap();


            CreateMap<ViewAgentCommissionDto, AgentCommission>()
              .ForMember(des => des.CreatedDate, mo => mo.MapFrom(src => System.DateTime.Now))
              .ForMember(des => des.ModifiedDate, mo => mo.MapFrom(src => System.DateTime.Now));




            // This mapping has to be removed <Commission, ViewCommissionDto>()
            //CreateMap<CommissionSearch, ViewCommissionDto>()
            //    .ForMember(des => des.CommissionId, mo => mo.MapFrom(src => src.Id))
            //    .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.PolicyNumber))
            //    .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Company))
            //    .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => src.Insured))
            //    .ForMember(des => des.Renewal, mo => mo.MapFrom(src => src.RenewalType))
            //    .ForMember(des => des.TotalAmount, mo => mo.MapFrom(src => src.Total));
        }
    }
}
