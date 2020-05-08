using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPeopleRepository : IRepository<People>
    {
        ICollection<People> GetInsuredDetails(int policyId);
        IQueryResult<People> Find(ISearchCriteria criteria);
        People GetById(long? id);
        People GetDetails(long id);
    }
}
