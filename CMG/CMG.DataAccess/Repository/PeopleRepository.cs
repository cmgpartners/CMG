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
                Pnotes = x.Pnotes,
                SalesforceId = x.SalesforceId
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
            return w => w.PeoplePolicys.Any(x => x.Policy.Policynum == contains && x.Del == false);
        }
        private static Expression<Func<People, bool>> CompanyCodeExpression(string equal)
        {
            return w => w.PeoplePolicys.Any(x => x.Policy.Company == equal && x.Del == false);
        }
        private static Expression<Func<People, bool>> PolicyDateExpression(string greaterThan, string lessThan)
        {
            if (!string.IsNullOrEmpty(greaterThan)
               && !string.IsNullOrEmpty(lessThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate >= Convert.ToDateTime(greaterThan) && x.Policy.Issuedate <= Convert.ToDateTime(lessThan) && x.Del == false);
            }
            if (!string.IsNullOrEmpty(greaterThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate >= Convert.ToDateTime(greaterThan) && x.Del == false);
            }

            if (!string.IsNullOrEmpty(lessThan))
            {
                return w => w.PeoplePolicys.Any(x => x.Policy.Issuedate <= Convert.ToDateTime(lessThan) && x.Del == false); 
            }
            return w => true;
        }
        public People GetById(long? id)
        {
            return Context.People.SingleOrDefault(x => x.Keynump == (id ?? 0));
        }
        public People GetDetails(long id)
        {
            var query = _context.People.Where(p => p.Keynump == id).AsQueryable()
                        .Include(p => p.RelPpKeynump2Navigation).ThenInclude(x => x.KeynumpNavigation)
                        .Include(p => p.RelPpKeynumpNavigation).ThenInclude(x => x.Keynump2Navigation)
                        .Include(p => p.RelBp).ThenInclude(x => x.KeynumbNavigation)
                        .Include(p => p.Cases).ThenInclude(x => x.CaseAgents).ThenInclude(x => x.Agent)
                        .Include(p => p.PeoplePolicys).ThenInclude(x=> x.Policy);
            var people = query.Select(x => new People
            {
                Keynump = x.Keynump,
                Firstname = x.Firstname,
                Commname = x.Commname,
                Midname = x.Midname,
                Lastname = x.Lastname,
                Picpath = x.Picpath,
                RelBp = x.RelBp.Where(b => b.Primary == true).Select(rb => new RelBp()
                {
                    Primary = rb.Primary,
                    KeynumbNavigation = rb.KeynumbNavigation
                }).ToList(),
                Dphonebus = x.Dphonebus,
                Phonecar = x.Phonecar,
                Clienttyp = x.Clienttyp,
                Pstatus = x.Pstatus,
                SvcType = x.SvcType,
                Cases = x.Cases.Select(c => new Cases()
                { 
                    Tdate = c.Tdate,
                    Title = c.Title,
                    Case1 = c.Case1,
                    Case2 = c.Case2,
                    Case3 = c.Case3,
                    Case4 = c.Case4,
                    Case5 = c.Case5,
                    Case6 = c.Case6,
                    Case7 = c.Case7,
                    Case8 = c.Case8,
                    Case1d = c.Case1d,
                    Case2d = c.Case2d,
                    Case3d = c.Case3d,
                    Case4d = c.Case4d,
                    Case5d = c.Case5d,
                    Case6d = c.Case6d,
                    Case7d = c.Case7d,
                    Case8d = c.Case8d,
                    Casey1 = c.Casey1,
                    Casey2 = c.Casey2,
                    Casey3 = c.Casey3,
                    Casey4 = c.Casey4,
                    Casey5 = c.Casey5,
                    Casey6 = c.Casey6,
                    Casey7 = c.Casey7,
                    Casey8 = c.Casey8,
                    CaseStage = c.CaseStage,
                    Casenew = c.Casenew,
                    RevLocn = c.RevLocn,
                    CaseAgents = c.CaseAgents.Select(ca => new CaseAgent()
                    {
                        AgentOrder = ca.AgentOrder,
                        Agent = ca.Agent
                    })
                }),
                PeoplePolicys = x.PeoplePolicys.Where(p => p.Del == false).Select(p => new PeoplePolicys()
                {
                    Keynumo = p.Keynumo,
                    Policy = new Policys()
                    {
                        Amount = p.Policy.Amount,
                        Payment = p.Policy.Payment
                    }
                }).ToList(),
                RelPpKeynump2Navigation = x.RelPpKeynump2Navigation.Select(rp => new RelPp() 
                { 
                    RelCode = rp.RelCode,
                    RelGrp = rp.RelGrp,
                    KeynumpNavigation = rp.KeynumpNavigation,
                    Keynump2Navigation = rp.Keynump2Navigation
                }),
                RelPpKeynumpNavigation = x.RelPpKeynumpNavigation.Select(rp => new RelPp()
                {
                    RelCode = rp.RelCode,
                    RelGrp = rp.RelGrp,
                    KeynumpNavigation = rp.KeynumpNavigation,
                    Keynump2Navigation = rp.Keynump2Navigation
                }),
            }).FirstOrDefault();
            List<RelPp> peopleRelations = new List<RelPp>();
            peopleRelations.AddRange(people.RelPpKeynumpNavigation);
            peopleRelations.AddRange(people.RelPpKeynump2Navigation);
            people.RelPpKeynumpNavigation = peopleRelations;
            return people;
        }
    }
}