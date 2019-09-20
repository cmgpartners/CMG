﻿using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using LinqKit;

namespace CMG.DataAccess.Repository
{
    public class CommissionSearchRepository : Repository<Commission>, ICommissionSearchRepository
    {
        private readonly pb2Context _context;

        public CommissionSearchRepository(pb2Context context) : base(context)
        {
            _context = context;
        }

        public IQueryResult<CommissionSearch> Search(ISearchCriteria criteria)
        {
            var query = Context.Commission.AsQueryable().Include(x => x.AgentCommission).ThenInclude(x => x.Agent)
                .Include(x => x.Policy)
                .Select(x => new CommissionSearch
                {
                    Id = x.Id,
                    PayDate = x.PayDate,
                    CommissionType = x.CommissionType,
                    PolicyId = x.PolicyId,
                    RenewalType = x.RenewalType,
                    Total = x.Total.HasValue ? Convert.ToDecimal(x.Total.Value) : 0,
                    Insured = x.Insured,
                    PolicyNumber = x.Policy.Policynum,
                    AgentCommissions = x.AgentCommission.Select(a => new AgentCommission
                    {
                        Agent = a.Agent,
                        Split = a.Split,
                        Commission = a.Commission
                    }).ToList(),

                });
            IQueryable<CommissionSearch> queryable = query;

            if ((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if (criteria.SortBy != null)
            {
                queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var totalRecords = queryable.Count();
            var totalAmount = queryable.AsEnumerable().Sum(x => x.Total);

            if (criteria.Page.HasValue
                && criteria.PageSize.HasValue)
            {
                var skip = (criteria.Page.Value - 1) * criteria.PageSize.Value;
                var pageSize = criteria.PageSize.Value;
                queryable = queryable.Skip(skip);
                queryable = queryable.Take(pageSize);
            }

            var result = queryable.ToList();


            return new PagedQueryResult<CommissionSearch>()
            {
                TotalAmount = Convert.ToDecimal(totalAmount),
                Result = result,
                TotalRecords = totalRecords
            };
        }

        private static Expression<Func<CommissionSearch, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<CommissionSearch, bool>> predicate = null;

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

        private IQueryable<CommissionSearch> OrderByPredicate(IQueryable<CommissionSearch> query, SortBy criteriaSortBy)
        {
            bool DescendingOrder = criteriaSortBy.DescendingOrder.HasValue && criteriaSortBy.DescendingOrder.Value;

            switch (criteriaSortBy.Property.ToLower())
            {
                case "policynumber":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.PolicyNumber);
                    }
                    return query.OrderBy(o => o.PolicyNumber);
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
                        return query.OrderByDescending(o => o.CommissionType);
                    }
                    return query.OrderBy(o => o.CommissionType);
                case "paydate":
                    if (DescendingOrder)
                    {
                        return query.OrderByDescending(o => o.PayDate);
                    }
                    return query.OrderBy(o => o.PayDate);
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

        private static Expression<Func<CommissionSearch, bool>> FilterByClausure(FilterBy filterBy)
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

        private static Expression<Func<CommissionSearch, bool>> DateRangeExpression(string greaterThan, string lessThan)
        {
            if (!string.IsNullOrEmpty(greaterThan)
                && !string.IsNullOrEmpty(lessThan))
            {
                return w => w.PayDate >= Convert.ToDateTime(greaterThan)
                    && w.PayDate <= Convert.ToDateTime(lessThan);
            }

            if (!string.IsNullOrEmpty(greaterThan))
            {
                return w => w.PayDate >= Convert.ToDateTime(greaterThan);
            }

            if (!string.IsNullOrEmpty(lessThan))
            {
                return w => w.PayDate <= Convert.ToDateTime(lessThan);
            }
            return w => true;
        }

        private static Expression<Func<CommissionSearch, bool>> PolicyNumberExpression(string contains)
        {
            return w => w.PolicyNumber.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<CommissionSearch, bool>> InsuredNameExpession(string contains)
        {
            return w => w.Insured.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<CommissionSearch, bool>> CompanyNameExpession(string contains)
        {
            return w => w.Company.ToLowerInvariant().Contains(contains.ToLowerInvariant());
        }

        private static Expression<Func<CommissionSearch, bool>> AgentExpression(string equals)
        {
            return w => w.AgentCommissions.Any(x => x.AgentId == Convert.ToInt32(equals));
        }

        private static Expression<Func<CommissionSearch, bool>> RenewalOrFYCExpression(string equal)
        {
            return w => w.CommissionType.Equals(equal.Trim());
        }

    }
}