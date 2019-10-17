using CMG.DataAccess.Domain;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface ICommissionRepository : IRepository<Comm>
    {
        IQueryResult<Comm> Find(ISearchCriteria criteria);

        Comm Find(long? id);
    }
}
