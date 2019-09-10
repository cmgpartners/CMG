using CMG.Common;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using System.Threading.Tasks;
using LinqKit;
using System.Collections.Generic;

namespace CMG.DataAccess.Respository
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
            var query = Context.Comm.AsQueryable();
            IQueryable<Comm> queryable = query;

            if((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if(criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var totalRecords = queryable.Count();

            if(criteria.Page.HasValue
                && criteria.PageSize.HasValue)
            {
                var skip = (criteria.Page.Value - 1) * criteria.PageSize.Value;
                var pageSize = criteria.PageSize.Value;
                queryable = queryable.Skip(skip);
                queryable = queryable.Take(pageSize);
            }

            var result = queryable.ToList();

            return new PagedQueryResult<Comm>()
            {
                Result = result,
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
                        return query.OrderByDescending(o => o.Policynum);
                    }
                    return query.OrderBy(o => o.Policynum);
                case "insuredname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Insured);
                    }
                    return query.OrderBy(o => o.Insured);
                case "companyname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Company);
                    }
                    return query.OrderBy(o => o.Company);
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
                case "insuredname":
                    return InsuredNameExpession(filterBy.Contains);
                case "companyname":
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
            return w => w.Policynum.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> InsuredNameExpession(string contains)
        {
            return w => w.Insured.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> CompanyNameExpession(string contains)
        {
            return w => w.Company.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<Comm, bool>> AgentExpression(string equals)
        {
            Expression<Func<Comm, bool>> predicate = null;

            switch (Convert.ToInt32(equals))
            {
                case (int)Enums.AgentEnum.Bob:
                    predicate = w => w.Bob > 0;
                break;
                case (int)Enums.AgentEnum.Frank:
                    predicate = w => w.Frank > 0;
                break;
                case (int)Enums.AgentEnum.Kate:
                    predicate = w => w.Marty > 0;
                break;
                case (int)Enums.AgentEnum.Mary:
                    predicate = w => w.Mary > 0;
                break;
                case (int)Enums.AgentEnum.Others:
                    predicate = w => w.Other > 0;
                break;
                case (int)Enums.AgentEnum.Peter:
                    predicate = w => w.Peter > 0;
                break;
                case (int)Enums.AgentEnum.Marty:
                    predicate = w => w.Marty > 0;
                    break;
            }
            return predicate;

        }

        private static Expression<Func<Comm,bool>> RenewalOrFYCExpression(string equal)
        {
            return w => w.Commtype.Equals(equal.Trim());
        }

    }
}
