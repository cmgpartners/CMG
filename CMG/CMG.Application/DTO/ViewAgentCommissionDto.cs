﻿using CMG.Common;

namespace CMG.Application.DTO
{
    public class ViewAgentCommissionDto
    {
        public decimal Commission { get; set; }
        public decimal Split { get; set; }
        public ViewAgentDto Agent { get; set; } = new ViewAgentDto();
    }
}
