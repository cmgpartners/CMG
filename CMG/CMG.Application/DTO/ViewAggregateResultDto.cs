using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewAggregateResultDto
    {
        public int? AgentId { get; set; }
        public double? TotalCommission { get; set; }
        public string AgentName { get; set; }
        public string AgentColor { get; set; }
        public string FontWeight { get; set; }
    }
}
