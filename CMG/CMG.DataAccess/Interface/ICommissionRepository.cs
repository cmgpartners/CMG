using CMG.DataAccess.Domain;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface ICommissionRepository : IRepository<Commission>
    {
        IQueryResult<Commission> Find(ISearchCriteria criteria);
    }
}
