using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using LinqKit;
using System.Collections.Generic;

namespace CMG.DataAccess.Repository
{
    public class CommissionRepository : Repository<Comm>, ICommissionRepository
    {
        private readonly pb2Context _context;

        public CommissionRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public List<Comm> GetRenewals(string yrmo)
        {
            return Context.Comm.Where(x => x.Yrmo == yrmo && x.Commtype == "R").Include(x => x.AgentCommissions).ThenInclude(x => x.Agent).ToList();
        }
        public Comm Find(long? id)
        {
            return Context.Set<Comm>().Include(x => x.AgentCommissions).SingleOrDefault(x => x.Keycomm == (id ?? 0));
        }
        public IQueryResult<Comm> Find(ISearchCriteria criteria)
        {
            var query = Context.Comm.AsQueryable().Include(x => x.AgentCommissions).ThenInclude(x => x.Agent);

            IQueryable<Comm> queryable = query;

            if((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if(criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var result = queryable.Select(x => new Comm
            {
                Keycomm = x.Keycomm,
                Paydate = x.Paydate,
                Commtype = x.Commtype,
                Keynumo = x.Keynumo,
                Renewals = x.Renewals,
                Total = x.Total,
                Insured = x.Insured,
                Policynum = x.Policynum,
                Company = x.Company,
                Comment = x.Comment,
                Premium = x.Premium,
                Yrmo = x.Yrmo,
                Cr8Date = x.Cr8Date,
                Cr8Locn = x.Cr8Locn,
                Del = x.Del,
                RevDate = x.RevDate,
                RevLocn = x.RevLocn,
                AgentCommissions = x.AgentCommissions.Select(a => new AgentCommission
                {
                    Id = a.Id,
                    CommissionId = a.CommissionId,
                    AgentId = a.AgentId,
                    Agent = a.Agent,
                    Split = a.Split,
                    AgentOrder = a.AgentOrder,
                    Commission = a.Commission,
                    CreatedBy = a.CreatedBy,
                    CreatedDate = a.CreatedDate,
                    ModifiedDate = a.ModifiedDate,
                    ModifiedBy = a.ModifiedBy,
                    IsDeleted = a.IsDeleted
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
                case "comment":
                    return CommentExpession(filterBy.Contains);
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
        private static Expression<Func<Comm, bool>> CommentExpession(string contains)
        {
            return w => (w.Comment ?? string.Empty).ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }
    }
}
