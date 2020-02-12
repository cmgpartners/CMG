﻿using CMG.DataAccess.Domain;
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
            var query = Context.People.AsQueryable().Include(x => x.PeoplePolicys).Where(x => x.Keynump > 0);

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
            }).OrderBy(x => x.Commname).OrderBy(x => x.Lastname).OrderBy(x => x.Firstname);

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
                case "policynumber":
                    return PolicyNumberExpression(filterBy.Contains);
                case "companyname":
                    return CompanyCodeExpression(filterBy.Equal);
                case "policydate":
                    return PolicyDateExpression(filterBy.GreaterThan, filterBy.LessThan);
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
            return w => w.Lastname.StartsWith(contains);
        }
        private static Expression<Func<People, bool>> CommonNameExpression(string contains)
        {
            return w => w.Commname.StartsWith(contains);
        }
        private static Expression<Func<People,bool>> EntityTypeExpression(string equals)
        {
            return w => w.Clienttyp.Trim() == equals;
        }
        private static Expression<Func<People, bool>> PolicyNumberExpression(string contains)
        {
            return w => w.PeoplePolicys.Any(x => x.Policy.Policynum == contains);
        }
        private static Expression<Func<People, bool>> CompanyCodeExpression(string equal)
        {
            return w => w.PeoplePolicys.Any(x => x.Policy.Company == equal);
        }
        private static Expression<Func<People, bool>> PolicyDateExpression(string greaterThan, string lessThan)
        {
            if (!string.IsNullOrEmpty(greaterThan)
               && !string.IsNullOrEmpty(lessThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate >= Convert.ToDateTime(greaterThan) && x.Policy.Issuedate <= Convert.ToDateTime(lessThan));
            }
            if (!string.IsNullOrEmpty(greaterThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate >= Convert.ToDateTime(greaterThan));
            }

            if (!string.IsNullOrEmpty(lessThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate <= Convert.ToDateTime(lessThan)); 
            }
            return w => true;
        }
        public People GetById(long? id)
        {
            return Context.People.SingleOrDefault(x => x.Keynump == (id ?? 0));
        }
    }
}