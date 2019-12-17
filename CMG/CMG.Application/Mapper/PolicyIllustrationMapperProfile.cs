using AutoMapper;
using System;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;

namespace CMG.Application.Mapper
{
    public class PolicyIllustrationMapperProfile : Profile
    {
        public PolicyIllustrationMapperProfile()
        {

            CreateMap<PolIll, ViewPolicyIllustrationDto>()
               .ForMember(des => des.Keynumo, mo => mo.MapFrom(src => src.Keynumo))
               .ForMember(des => des.CashValue, mo => mo.MapFrom(src => src.Cv))
               .ForMember(des => des.DeathBenefit, mo => mo.MapFrom(src => src.Db))
               .ForMember(des => des.CashValueActual, mo => mo.MapFrom(src => src.Cvact))
               .ForMember(des => des.DeathBenefitActual, mo => mo.MapFrom(src => src.Dbact))
               .ForMember(des => des.CashValueReprojection, mo => mo.MapFrom(src => src.Cvre))
               .ForMember(des => des.DeathBenefitReprojection, mo => mo.MapFrom(src => src.Dbre))
               .ForMember(des => des.AnnualDeposit, mo => mo.MapFrom(src => src.Anndep))
               .ForMember(des => des.AdjustedCostBase, mo => mo.MapFrom(src => src.Acb))
               .ForMember(des => des.Display, mo => mo.MapFrom(src => src.Display.Trim()))
               .ForMember(des => des.NCPI, mo => mo.MapFrom(src => src.Ncpi))
               .ForMember(des => des.Increasingpay, mo => mo.MapFrom(src => src.Incpay))
               .ForMember(des => des.Lifepay, mo => mo.MapFrom(src => src.Lifepay))
               .ForMember(des => des.ModifiedDate, mo => mo.MapFrom(src => src.RevDate))
               .ForMember(des => des.ModifiedBy, mo => mo.MapFrom(src => src.RevLocn))
               .ForMember(des => des.CreatedDate, mo => mo.MapFrom(src => src.Cr8Date))
               .ForMember(des => des.CreatedBy, mo => mo.MapFrom(src => src.Cr8Locn))
               .ForMember(des => des.IsDeleted, mo => mo.MapFrom(src => src.Del))
               .ForMember(des => des.AnnualDepositReprojection, mo => mo.MapFrom(src => src.Anndepre))
               .ForMember(des => des.AnnualDepositActual, mo => mo.MapFrom(src => src.Anndepact))
               .ForMember(des => des.AdjustedCostBaseActual, mo => mo.MapFrom(src => src.Acbact))
               .ForMember(des => des.AdjustedCostBaseReprojection, mo => mo.MapFrom(src => src.Acbre))
               .ForMember(des => des.NCPIActual, mo => mo.MapFrom(src => src.Ncpiact))
               .ForMember(des => des.NCPIReprojection, mo => mo.MapFrom(src => src.Ncpire))
               .ForMember(des => des.DivisionScale, mo => mo.MapFrom(src => src.Divscale))
               .ForMember(des => des.CalendarYear, mo => mo.MapFrom(src => src.Yearcal));
        }
    }
}
