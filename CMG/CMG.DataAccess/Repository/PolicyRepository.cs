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

        public IQueryResult<Policys> Find(ISearchCriteria criteria)
        {
            var query = Context.Policys.AsQueryable().Include(x => x.PolicyAgent).ThenInclude(x => x.Agent);

            IQueryable<Policys> queryable = query;

            if ((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }

            var result = queryable.Select(x => new Policys
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
            });

            var totalRecords = result.Count();

            if (criteria.Page.HasValue
                && criteria.PageSize.HasValue)
            {
                var skip = (criteria.Page.Value - 1) * criteria.PageSize.Value;
                var pageSize = criteria.PageSize.Value;
                result = result.Skip(skip);
                result = result.Take(pageSize);
            }

            return new PagedQueryResult<Policys>()
            {
                TotalAmount = 0.0M,
                Result = result.ToList(),
                TotalRecords = totalRecords
            };
        }
        private static Expression<Func<Policys, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Policys, bool>> predicate = null;

            foreach (var filterBy in criteria.FilterBy)
            {
                if (predicate == null)
                {
                    predicate = FilterByClausure(filterBy);
                }
                else
                {
                    predicate = predicate.And(FilterByClausure(filterBy));
                }
            }
            return predicate;
        }
        private static Expression<Func<Policys, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "policynumber":
                    return PolicyNumberExpression(filterBy.Equal);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }
        private static Expression<Func<Policys, bool>> PolicyNumberExpression(string equal)
        {
            return w => w.Policynum.ToLowerInvariant().Equals(equal.ToLowerInvariant());
        }
    }
}
