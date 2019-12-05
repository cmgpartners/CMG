using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using LinqKit;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace CMG.DataAccess.Repository
{
    public class PolicyRepository : Repository<Policys>, IPolicyRepository
    {
        private readonly pb2Context _context;

        public PolicyRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public ICollection<Policys> GetAllPolicyNumber()
        {
            var result = _context.Policys.Select(x => new Policys
            {
                Keynumo = x.Keynumo,
                Policynum = x.Policynum
            }).ToList();

            return result;
        }

        public Policys FindByPolicyNumber(string policyNumber)
        {
            var query = Context.Policys.Where(p => p.Policynum == policyNumber).AsQueryable().Include(x => x.PolicyAgent).ThenInclude(x => x.Agent);
            return query.Select(x => new Policys
            {
                Keynumo = x.Keynumo,
                Policynum = x.Policynum,
                Company = x.Company,
                Insur = x.Insur,
                PolicyAgent = x.PolicyAgent.Select(a => new PolicyAgent
                {
                    Id = a.Id,
                    PolicyId = a.PolicyId,
                    AgentId = a.AgentId,
                    Agent = a.Agent,
                    Split = a.Split,
                    AgentOrder = a.AgentOrder
                })
            }).FirstOrDefault();
        }

        //public IQueryable<Policys> Find(ISearchCriteria criteria)
        //{
        //    var query = Context.Business.Include(x => x.BusinessPolicys)
        //}
    }
}
