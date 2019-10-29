using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using LinqKit;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;

namespace CMG.DataAccess.Repository
{
    public class WithdrawalRepository : Repository<Withd>, IWithdrawalsRepository
    {
        private readonly pb2Context _context;

        public WithdrawalRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public IQueryResult<Withd> Find(ISearchCriteria criteria)
        {
            var query = Context.Withd.AsQueryable().Include(x => x.AgentWithdrawal).ThenInclude(x => x.Agent);

            IQueryable<Withd> queryable = query;

            if ((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }

            var totalRecords = queryable.Count();

            if (criteria.Page.HasValue
                && criteria.PageSize.HasValue)
            {
                var skip = (criteria.Page.Value - 1) * criteria.PageSize.Value;
                var pageSize = criteria.PageSize.Value;
                queryable = queryable.Skip(skip);
                queryable = queryable.Take(pageSize);
            }

            return new PagedQueryResult<Withd>()
            {
                TotalAmount = 0,
                Result = queryable.ToList(),
                TotalRecords = totalRecords
            };
        }

        private static Expression<Func<Withd, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Withd, bool>> predicate = null;

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


        private static Expression<Func<Withd, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "dtype":
                    return DTypeExpression(filterBy.Equal);
                case "yrmo":
                    return YearMonthExpression(filterBy.Equal);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }

        private static Expression<Func<Withd, bool>> DTypeExpression(string equal)
        {
            return w => w.Dtype.Equals(equal.Trim());
        }

        private static Expression<Func<Withd, bool>> YearMonthExpression(string equal)
        {
            return w => w.Yrmo.Equals(equal.Trim());
        }
    }
}
