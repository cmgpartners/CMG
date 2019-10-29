using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IAgentRepository : IRepository<Agent>
    {
        IQueryResult<Agent> Find(ISearchCriteria criteria);
    }
}
