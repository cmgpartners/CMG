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
    public class PolicyRepository : Repository<Policys>, IPolicyRepository
    {
        #region Member variables
        private readonly pb2Context _context;
        private string excludeCategory = "0, 1, 2, 3";
        #endregion Member variables
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

        public Policys FindByPolicyNumber(string policyNumber)
        {
            var query = Context.Policys.Where(p => p.Policynum == policyNumber).AsQueryable().Include(x => x.PolicyAgent).ThenInclude(x => x.Agent);
            return query.Select(x => new Policys
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
                }).ToList()
            }).FirstOrDefault();
        }

        public IQueryResult<Policys> Find(ISearchCriteria criteria)
        {
            var excludeCategoryList = excludeCategory.Split(',').Select(x => x.Trim()).ToList();
            var query = Context.Policys.Include(x => x.PeoplePolicys).Include(p => p.PolicyAgent).ThenInclude(a => a.Agent);

            IQueryable<Policys> queryable = query;
            if ((criteria.FilterBy?.Count() ?? 0) > 0)
            {
                queryable = queryable.Where(GetPredicate(criteria));
            }
            if (criteria.SortBy != null)
            {
                //queryable = OrderByPredicate(queryable, criteria.SortBy);
            }

            var result = queryable.Select(x => new Policys
            {
                Keynumo = x.Keynumo,
                Policynum = x.Policynum,
                Company = x.Company,
                Amount = x.Amount,
                Payment = x.Payment,
                Status = x.Status,
                Frequency = x.Frequency,
                Type = x.Type,
                Plancode = x.Plancode,
                Risk = x.Risk,
                Class = x.Class,
                Currency = x.Currency,
                Cr8Date = x.Cr8Date,
                Cr8Locn = x.Cr8Locn,
                RevDate = x.RevDate,
                RevLocn = x.RevLocn,
                Reprojdate = x.Reprojdate,
                IssueAge = x.IssueAge,
                Comment = x.Comment,
                NoteCli = x.NoteCli,
                NoteInt = x.NoteInt, 
                Issuedate =x.Issuedate,
                Dateplaced = x.Dateplaced,
                PeoplePolicys = x.PeoplePolicys.Where(x => !excludeCategoryList.Contains(x.Catgry)).Select(a => new PeoplePolicys
                {
                    Keynump = a.Keynump,
                    Keynumo = a.Keynumo,
                    Hname = a.Hname,
                    Catgry = a.Catgry,
                    Relatn = a.Relatn,
                    Split = a.Split
                }).ToList(),
                PolicyAgent = x.PolicyAgent.Select(p => new PolicyAgent
                {
                    Id = p.Id,
                    AgentId = p.AgentId,
                    Agent = p.Agent,
                    Split = p.Split,
                    AgentOrder = p.AgentOrder,
                    IsDeleted = p.IsDeleted
                }).ToList()
            });

            var totalRecords = result.Count();
            return new PagedQueryResult<Policys>()
            {
                Result = result.ToList(),
                TotalRecords = totalRecords
            };
        }
        
        private static Expression<Func<Policys, bool>> GetPredicate(ISearchCriteria criteria)
        {
            Expression<Func<Policys, bool>> predicate = null;
            foreach(var filterBy in criteria.FilterBy)
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

        private static Expression<Func<Policys, bool>> FilterByClausure(FilterBy filterBy)
        {
            switch (filterBy.Property.ToLower())
            {
                case "keynump":
                    return KeynumpExpression(filterBy.Equal);
                default:
                    throw new InvalidOperationException($"Can not filter for criteria: filter by {filterBy.Property}");
            }
        }

        private static Expression<Func<Policys, bool>> KeynumpExpression(string equals)
        {
            return w => w.PeoplePolicys.Any(x => x.Keynump == Convert.ToInt32(equals));
        }

        public Policys GetById(long? id)
        {
            return Context.Policys.SingleOrDefault(x => x.Keynumo == (id ?? 0));
        }
    }
}
