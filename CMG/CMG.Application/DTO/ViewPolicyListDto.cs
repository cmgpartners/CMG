﻿using System;
using System.Collections.Generic;

namespace CMG.Application.DTO
{
    public class ViewPolicyListDto
    {
        public int Id { get; set; }
        public string PolicyNumber { get; set; }
        public string CompanyName { get; set; }
        public decimal FaceAmount { get; set; }
        public decimal Payment { get; set; }
        public string Status { get; set; }
        public string Frequency { get; set; }
        public string Type { get; set; }
        public string PlanCode { get; set; }
        public string Rating { get; set; }        
        public string Class { get; set; }        
        public string Currency { get; set; }        
        public DateTime? PolicyDate { get; set; }        
        public DateTime? PlacedOn { get; set; }        
        public DateTime? ReprojectedOn { get; set; }        
        public int Age { get; set; }        
        public string PolicyNotes { get; set; }
        public string ClientNotes { get; set; }
        public string InternalNotes { get; set; }
        public DateTime ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public ICollection<ViewPolicyAgentDto> PolicyAgent { get; set; } = new List<ViewPolicyAgentDto>();
        public ICollection<ViewPeoplePolicyDto> PeoplePolicy { get; set; } = new List<ViewPeoplePolicyDto>();
        public ICollection<ViewPeoplePolicyDto> PolicyAgents { get; set; } = new List<ViewPeoplePolicyDto>();
    }
}
