﻿using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewWithdrawalDto
    {
        public int WithdrawalId { get; set; }
        public string Dtype { get; set; }
        public string Yrmo { get; set; }
        public string Desc { get; set; }
        public string Ctype { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string CreatedBy { get; set; }
        public DateTime? ModifiedDate { get; set; } = null;
        public string ModifiedBy { get; set; } = null;
        public bool IsDeleted { get; set; }
        public ICollection<ViewAgentWithdrawalDto> AgentWithdrawals { get; set; } = new List<ViewAgentWithdrawalDto>();
    }
}
