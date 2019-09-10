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
        }

        public void AfterMapAgents(Comm source, ViewCommissionDto des)
        {
            var agents = new List<ViewAgentCommissionDto>();
            var agent = new ViewAgentCommissionDto();
            if(source != null)
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
