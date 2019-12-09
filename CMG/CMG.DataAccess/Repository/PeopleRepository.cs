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
    public class PeopleRepository : Repository<People>, IPeopleRepository
    {
        private readonly pb2Context _context;

        public PeopleRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public IQueryResult<People> Find(ISearchCriteria criteria)
        {
            var query = Context.People.AsQueryable().Include(x => x.PeoplePolicys);

            IQueryable<People> queryable = query;

            if((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if(criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var result = queryable.Select(x => new People
            {
                Keynump = x.Keynump,
                Firstname = x.Firstname,
                Lastname = x.Lastname,
                Commname = x.Commname,
                Birthdate = x.Birthdate,
                Smoker = x.Smoker,
                Clienttyp = x.Clienttyp,
                Pstatus = x.Pstatus,
                SvcType = x.SvcType,
                Pnotes = x.Pnotes
            });

            var totalRecords = result.Count();
            return new PagedQueryResult<People>()
            {
                Result = result.ToList(),
                TotalRecords = totalRecords
            };
        }
        private static Expression<Func<People, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<People, bool>> predicate = null;

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
        private static Expression<Func<People, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "firstname":
                    return FirstNameExpression(filterBy.Contains);
                case "lastname":
                    return LastNameExpression(filterBy.Contains);
                case "commonname":
                    return CommonNameExpression(filterBy.Contains);
                case "entitytype":
                    return EntityTypeExpression(filterBy.Equal);
                case "keynump":
                    return KeynumpExpression(filterBy.In);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }
        private IQueryable<People> OrderByPredicate(IQueryable<People> query, SortBy criteriaSortBy)
        {
            bool DescendingOrder = criteriaSortBy.DescendingOrder.HasValue && criteriaSortBy.DescendingOrder.Value;

            switch (criteriaSortBy.Property.ToLower())
            {
                case "firstname":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Firstname);
                    }
                    return query.OrderBy(o => o.Firstname);
                case "lastname":
                    if(DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Lastname);
                    }
                    return query.OrderBy(o => o.Lastname);
                case "commonname":
                    if(DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.Commname);
                    }
                    return query.OrderBy(o => o.Commname);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {criteriaSortBy.Property}");
            }
        }
        private static Expression<Func<People, bool>> FirstNameExpression(string contains)
        {
            return w => w.Firstname.ToLowerInvariant().StartsWith(contains.ToLowerInvariant());
        }
        private static Expression<Func<People, bool>> LastNameExpression(string contains)
        {
            return w => w.Lastname.ToLowerInvariant().StartsWith(contains.ToLowerInvariant());
        }
        private static Expression<Func<People, bool>> CommonNameExpression(string contains)
        {
            return w => w.Commname.ToLowerInvariant().StartsWith(contains.ToLowerInvariant());
        }
        private static Expression<Func<People,bool>> EntityTypeExpression(string equals)
        {
            return w => w.Clienttyp.Trim() == equals;
        }
        private static Expression<Func<People, bool>> KeynumpExpression(string filterIn)
        {
            var keynumpList = filterIn.Split(',').Select(x => x.Trim()).ToList();
            return w => keynumpList.Contains(w.Keynump.ToString());
        }
    }
}