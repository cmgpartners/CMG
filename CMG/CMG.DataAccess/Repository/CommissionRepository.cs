using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using LinqKit;

namespace CMG.DataAccess.Repository
{
    public class CommissionRepository : Repository<Comm>, ICommissionRepository
    {
        private readonly pb2Context _context;

        public CommissionRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public IQueryResult<Comm> Find(ISearchCriteria criteria)
        {
            var query = Context.Comm.AsQueryable().Include(x => x.AgentCommissions).ThenInclude(x => x.Agent)
                .Include(x => x.Policy);
            IQueryable<Comm> queryable = query;

            if((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if(criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var result = queryable.Select(x => new Commission
            {
                Id = x.Id,
                PayDate = x.PayDate,
                CommissionType = x.CommissionType,
                PolicyId = x.PolicyId,
                RenewalType = x.RenewalType,
                Total = x.Total,
                Insured = x.Insured,
                Policy = new Policys
                {
                    Policynum = x.Policy.Policynum,
                    Company = x.Policy.Company
                },
                Comment = x.Comment,
                AgentCommissions = x.AgentCommissions.Select(a => new AgentCommission
                {
                    AgentId = a.AgentId,
                    Agent = a.Agent,
                    Split = a.Split,
                    Commission = a.Commission
                })
            });

            var totalRecords = result.Count();
            var totalAmount = result.AsEnumerable().Sum(x => x.Total);

            if (criteria.Page.HasValue
                && criteria.PageSize.HasValue)
            {
                var skip = (criteria.Page.Value - 1) * criteria.PageSize.Value;
                var pageSize = criteria.PageSize.Value;
                result = result.Skip(skip);
                result = result.Take(pageSize);
            }

            return new PagedQueryResult<Comm>()
            {
                TotalAmount = Convert.ToDecimal(totalAmount),
                Result = result.ToList(),
                TotalRecords = totalRecords
            };
        }

        private static Expression<Func<Comm, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Comm, bool>> predicate = null;

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

        private IQueryable<Comm> OrderByPredicate(IQueryable<Comm> query, SortBy criteriaSortBy)
        {
            bool DescendingOrder = criteriaSortBy.DescendingOrder.HasValue && criteriaSortBy.DescendingOrder.Value;

            switch(criteriaSortBy.Property.ToLower())
            {
                case "policynumber":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Policy.Policynum);
                    }
                    return query.OrderBy(o => o.Policy.Policynum);
                case "insuredname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Insured);
                    }
                    return query.OrderBy(o => o.Insured);
                case "companyname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Policy.Company);
                    }
                    return query.OrderBy(o => o.Policy.Company);
                case "fyc":
                case "renewal":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Commtype);
                    }
                    return query.OrderBy(o => o.Commtype);
                case "paydate":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Paydate);
                    }
                    return query.OrderBy(o => o.Paydate);
                case "total":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Total);
                    }
                    return query.OrderBy(o => o.Total);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {criteriaSortBy.Property}");
            }

        }

        private static Expression<Func<Comm, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "policynumber":
                    return PolicyNumberExpression(filterBy.Contains);
                case "insured":
                    return InsuredNameExpession(filterBy.Contains);
                case "company":
                    return CompanyNameExpession(filterBy.Contains);
                case "agent":
                    return AgentExpression(filterBy.Equal);
                case "fyc":
                case "renewal":
                    return RenewalOrFYCExpression(filterBy.Equal);
                case "paydate":
                    return DateRangeExpression(filterBy.GreaterThan, filterBy.LessThan);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }

        private static Expression<Func<Comm, bool>> DateRangeExpression(string greaterThan, string lessThan)
        {
            if(!string.IsNullOrEmpty(greaterThan)
                && !string.IsNullOrEmpty(lessThan))
            {
                return w => w.Paydate >= Convert.ToDateTime(greaterThan)
                    && w.Paydate <= Convert.ToDateTime(lessThan);
            }

            if(!string.IsNullOrEmpty(greaterThan))
            {
                return w => w.Paydate >= Convert.ToDateTime(greaterThan);
            }

            if (!string.IsNullOrEmpty(lessThan))
            {
                return w => w.Paydate <= Convert.ToDateTime(lessThan);
            }
            return w => true;
        }

        private static Expression<Func<Comm, bool>> PolicyNumberExpression(string contains)
        {
            return w => w.Policy.Policynum.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> InsuredNameExpession(string contains)
        {
            return w => w.Insured.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> CompanyNameExpession(string contains)
        {
            return w => w.Policy.Company.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> AgentExpression(string equals)
        {
            return w => w.AgentCommissions.Any(x => x.AgentId == Convert.ToInt32(equals));
        }

        private static Expression<Func<Comm, bool>> RenewalOrFYCExpression(string equal)
        {
            return w => w.Commtype.Equals(equal.Trim());
        }

    }
}
