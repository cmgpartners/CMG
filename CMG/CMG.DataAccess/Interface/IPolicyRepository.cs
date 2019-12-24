using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPolicyRepository : IRepository<Policys>
    {
        ICollection<Policys> GetAllPolicyNumber();

        Policys FindByPolicyNumber(string policyNumber);

        IQueryResult<Policys> Find(ISearchCriteria criteria);
        public Policys GetById(long? id);
    }
}
