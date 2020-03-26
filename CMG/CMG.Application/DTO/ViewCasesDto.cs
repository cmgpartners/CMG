using System;
using System.Collections.Generic;
using static CMG.Common.Enums;

namespace CMG.Application.DTO
{
    public class ViewCasesDto
    {
        public int CaseId { get; set; }
        public int PeopleId { get; set; }
        public string Title { get; set; }
        public int CaseStage { get; set; }
        public DateTime? TargetDate { get; set; }
        public int DiscoveryStartAmount { get; set; }
        public int DiscoveryEndAmount { get; set; }
        public int DesignStartAmount { get; set; }
        public int DesignEndAmount { get; set; }
        public int DeliveryStartAmount { get; set; }
        public int DeliveryEndAmount { get; set; }
        public int DestinyStartAmount { get; set; }
        public int DestinyEndAmount { get; set; }
        public DateTime? DiscoveryStartDate { get; set; }
        public DateTime? DiscoveryEndDate { get; set; }
        public DateTime? DesignStartDate { get; set; }
        public DateTime? DesignEndDate { get; set; }
        public DateTime? DeliveryStartDate { get; set; }
        public DateTime? DeliveryEndDate { get; set; }
        public DateTime? DestinyStartDate { get; set; }
        public DateTime? DestinyEndDate { get; set; }
        public string IsDiscoveryStart { get; set; }
        public string IsDiscoveryEnd { get; set; }
        public string IsDesignStart { get; set; }
        public string IsDesignEnd { get; set; }
        public string IsDeliveryStart { get; set; }
        public string IsDeliveryEnd { get; set; }
        public string IsDestinyStart { get; set; }
        public string IsDestinyEnd { get; set; }
        public bool Casenew { get; set; }
        public string ModifiedBy { get; set; }
        public ICollection<ViewCaseAgentDto> CaseAgents { get; set; }
        public string CaseStageName
        {
            get
            {
                return Enum.GetName(typeof(CaseStages), CaseStage);
            }
        }
        public DateTime? CaseStageDate
        {
            get
            {
                if (CaseStage == Convert.ToInt32(CaseStages.Discovery1))
                    return DiscoveryStartDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Discovery2))
                    return DiscoveryEndDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Design1))
                    return DesignStartDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Design2))
                    return DesignEndDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Delivery1))
                    return DeliveryStartDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Delivery2))
                    return DeliveryEndDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Destiny1))
                    return DestinyStartDate;
                else if (CaseStage == Convert.ToInt32(CaseStages.Destiny2))
                    return DestinyEndDate;
                else
                    return null;
            }
        }
        public int CaseStageAmount
        {
            get
            {
                if (CaseStage == Convert.ToInt32(CaseStages.Discovery1))
                    return DiscoveryStartAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Discovery2))
                    return DiscoveryEndAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Design1))
                    return DesignStartAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Design2))
                    return DesignEndAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Delivery1))
                    return DeliveryStartAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Delivery2))
                    return DeliveryEndAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Destiny1))
                    return DestinyStartAmount;
                else if (CaseStage == Convert.ToInt32(CaseStages.Destiny2))
                    return DestinyEndAmount;
                else
                    return 0;
            }
        }
    }
}
