﻿using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using LinqKit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;

namespace CMG.DataAccess.Repository
{
    public class AgentRepository : Repository<Agent>, IAgentRepository
    {
        private readonly pb2Context _context;

        public AgentRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public IQueryResult<Agent> Find(ISearchCriteria criteria)
        {
            var query = Context.Agent.AsQueryable();

            IQueryable<Agent> queryable = query;

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

            return new PagedQueryResult<Agent>()
            {
                TotalAmount = 0,
                Result = queryable.ToList(),
                TotalRecords = totalRecords
            };
        }

        private static Expression<Func<Agent, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Agent, bool>> predicate = null;

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


        private static Expression<Func<Agent, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "isexternal":
                    return IsExternalExpression(filterBy.Equal);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }

        private static Expression<Func<Agent, bool>> IsExternalExpression(string equal)
        {
            return w => w.IsExternal.Equals(Convert.ToBoolean(equal.Trim()));
        }
    }
}
