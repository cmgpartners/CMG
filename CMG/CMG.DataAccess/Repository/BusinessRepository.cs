using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using LinqKit;

namespace CMG.DataAccess.Repository
{
    public class BusinessRepository : Repository<Business>, IBusinessRepository
    {
        private readonly pb2Context _context;

        public BusinessRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public IQueryResult<Business> Find(ISearchCriteria criteria)
        {
            IQueryable<Business> queryable = Context.Business.AsQueryable().Include(x => x.BusinessPolicys).Where(x => x.Keynumb > 0);
            if ((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if (criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }
            var result = queryable;
            var totalRecords = result.Count();
            return new PagedQueryResult<Business>()
            {
                Result = result.ToList(),
                TotalRecords = totalRecords
            };
        }

        private static IQueryable<Business> OrderByPredicate(IQueryable<Business> query, SortBy criteriaSortBy)
        {
            bool DescendingOrder = criteriaSortBy.DescendingOrder.HasValue && criteriaSortBy.DescendingOrder.Value;
            switch (criteriaSortBy.Property.ToLower())
            {
                case "businessname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Busname);
                    }
                    return query.OrderBy(o => o.Busname);
                case "businessaddress":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Bstreet);
                    }
                    return query.OrderBy(o => o.Bstreet);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {criteriaSortBy.Property}");
            }
        }

        private static Expression<Func<Business, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Business, bool>> predicate = null;
            foreach (var filterBy in criteria.FilterBy)
            {
                if(predicate == null)
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
        private static Expression<Func<Business, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "businessname":
                    return BusinessNameExpression(filterBy.Contains);
                    break;
                case "businessaddress":
                    return BusinessAddressExpression(filterBy.Contains);
                    break;
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }

        private static Expression<Func<Business, bool>> BusinessNameExpression(string contains)
        {
            return w => w.Busname.ToLowerInvariant().StartsWith(contains.ToLowerInvariant());
        }
        private static Expression<Func<Business, bool>> BusinessAddressExpression(string contains)
        {
            return w => w.Bstreet.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }
        public Business GetById(long? id)
        {
            return Context.Business.SingleOrDefault(x => x.Keynumb == (id ?? 0));
        }
    }
}
