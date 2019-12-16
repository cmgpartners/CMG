using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewPolicyIllustrationDto
    {
        public int Keynumo { get; set; }
        public byte? Year { get; set; }
        public decimal CashValue { get; set; }
        public decimal DeathBenefit { get; set; }
        public decimal CashValueActual { get; set; }
        public decimal DeathBenefitActual { get; set; }
        public decimal CashValueReprojection { get; set; }
        public decimal DeathBenefitReprojection { get; set; }
        public decimal AnnualDeposit { get; set; }
        public decimal AdjustedCostBase { get; set; }
        public string Display { get; set; }
        public decimal NCPI { get; set; }
        public decimal Increasingpay { get; set; }
        public decimal Lifepay { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public bool IsDeleted { get; set; }
        public decimal AnnualDepositReprojection { get; set; }
        public decimal AnnualDepositActual { get; set; }
        public decimal AdjustedCostBaseActual { get; set; }
        public decimal AdjustedCostBaseReprojection { get; set; }
        public decimal NCPIActual { get; set; }
        public decimal NCPIReprojection { get; set; }
        public int? KeyIll { get; set; }
        public byte DivisionScale { get; set; }
        public short? CalendarYear { get; set; }
        public int Id { get; set; }
    }
}
