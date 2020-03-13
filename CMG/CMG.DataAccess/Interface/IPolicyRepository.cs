using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPolicyRepository : IRepository<Policys>
    {
        ICollection<Policys> GetAllPolicyNumber();
        ICollection<Policys> GetAutoSuggestionData();
        Policys FindByPolicyNumber(string policyNumber);
        IQueryResult<Policys> Find(ISearchCriteria criteria);
        Policys GetById(long? id);
    }
}
