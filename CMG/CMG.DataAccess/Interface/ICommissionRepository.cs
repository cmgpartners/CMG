using CMG.DataAccess.Domain;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface ICommissionRepository : IRepository<Comm>
    {
        new Task<ICollection<Comm>> Find(ISearchCriteria criteria);
    }
}
