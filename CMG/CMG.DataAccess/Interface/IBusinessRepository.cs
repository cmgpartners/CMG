using CMG.DataAccess.Domain;
using System.Collections.Generic;
using System.Linq;

namespace CMG.DataAccess.Interface
{
    public interface IBusinessRepository : IRepository<Business>
    {
        IQueryResult<Business> Find(ISearchCriteria criteria);
        Business GetById(long? id);
    }
}
