using System.Collections.Generic;
using AutoMapper;
using CMG.Application.DTO;
using CMG.Common;
using CMG.DataAccess.Domain;

namespace CMG.Application.Mapper
{
    public class CommissionMapperProfile : Profile
    {
        public CommissionMapperProfile()
        {
            CreateMap<Comm, ViewCommissionDto>()
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policynum))
                .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Company))
                .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => src.Insured))
                .ForMember(des => des.Renewal, mo => mo.MapFrom(src => src.Renewals))
                .ForMember(des => des.TotalAmount, mo => mo.MapFrom(src => src.Total))
                .ForMember(des => des.Agents, mo => mo.MapFrom(src => new List<ViewAgentCommissionDto>()))
                .AfterMap(AfterMapAgents);

            CreateMap<Commission, ViewCommissionDto>()
                .ForMember(des => des.CommissionId, mo => mo.MapFrom(src => src.Id))
                .ForMember(des => des.PolicyNumber, mo => mo.MapFrom(src => src.Policy.Policynum))
                .ForMember(des => des.CompanyName, mo => mo.MapFrom(src => src.Policy.Company))
                .ForMember(des => des.InsuredName, mo => mo.MapFrom(src => "InsuredName-Test"))
                .ForMember(des => des.Renewal, mo => mo.MapFrom(src => src.RenewalType))
                .ForMember(des => des.TotalAmount, mo => mo.MapFrom(src => src.Total))
                .ForMember(des => des.Agents, mo => mo.MapFrom(src => new List<ViewAgentCommissionDto>()))
                .AfterMap(AfterMapAgentCommissions);

            CreateMap<Agent, ViewAgentDto>();
        }

        public void AfterMapAgentCommissions(Commission source, ViewCommissionDto des)
        {
            ViewAgentCommissionDto agentCommission;
            List<AgentCommission> agentCommissions = new List<AgentCommission>(source.AgentCommission);
            if (source != null)
            {
                for (int i = 0; i < source.AgentCommission.Count; i++)
                {
                    agentCommission = new ViewAgentCommissionDto();
                    agentCommission.FirstName = agentCommissions[i].Agent.FirstName;
                    agentCommission.Commission = agentCommissions[i].Commission.HasValue ? (decimal)agentCommissions[i].Commission.Value : 0;
                    agentCommission.Split = agentCommissions[i].Split.HasValue ? (decimal)agentCommissions[i].Split.Value : 0;

                    agentCommission.Agent.Id = agentCommissions[i].Agent.Id;
                    agentCommission.Agent.FirstName = agentCommissions[i].Agent.FirstName;
                    agentCommission.Agent.LastName = agentCommissions[i].Agent.LastName;
                    agentCommission.Agent.MiddleName = agentCommissions[i].Agent.MiddleName;
                    agentCommission.Agent.AgentCode = agentCommissions[i].Agent.AgentCode;
                    agentCommission.Agent.Color = agentCommissions[i].Agent.Color;
                    agentCommission.Agent.IsDeleted = agentCommissions[i].Agent.IsDeleted;
                    des.Agents.Add(agentCommission);
                }
            }
        }

            public void AfterMapAgents(Comm source, ViewCommissionDto des)
        {
            var agents = new List<ViewAgentCommissionDto>();
            var agent = new ViewAgentCommissionDto();
            if (source != null)
            {
                if (source.Marty > 0)
                {
                    agent.FirstName = Enums.AgentEnum.Kate.ToString();
                    agent.Commission = source.Marty;
                    agent.Split = source.Split1;
                    agents.Add(agent);
                }

                if (source.Peter > 0)
                {
                    agent = new ViewAgentCommissionDto();
                    agent.FirstName = Enums.AgentEnum.Peter.ToString();
                    agent.Commission = source.Peter;
                    agent.Split = source.Split2;
                    agents.Add(agent);
                }
                if (source.Frank > 0)
                {
                    agent = new ViewAgentCommissionDto();
                    agent.FirstName = Enums.AgentEnum.Frank.ToString();
                    agent.Commission = source.Frank;
                    agent.Split = source.Split3;
                    agents.Add(agent);
                }
                if (source.Bob > 0)
                {
                    agent = new ViewAgentCommissionDto();
                    agent.FirstName = Enums.AgentEnum.Bob.ToString();
                    agent.Commission = source.Bob;
                    agent.Split = source.Split4;
                    agents.Add(agent);
                }
                if (source.Mary > 0)
                {
                    agent = new ViewAgentCommissionDto();
                    agent.FirstName = Enums.AgentEnum.Mary.ToString();
                    agent.Commission = source.Mary;
                    agent.Split = source.Split5;
                    agents.Add(agent);
                }
                if (source.Other > 0)
                {
                    agent = new ViewAgentCommissionDto();
                    agent.FirstName = Enums.AgentEnum.Others.ToString();
                    agent.Commission = source.Other;
                    agent.Split = source.Split6;
                    agents.Add(agent);
                }
            }
            des.Agents = agents;
        }
    }
}
