using CMG.DataAccess.Domain;

namespace CMG.DataAccess.Interface
{
    public interface ICommissionSearchRepository : IRepository<Comm>
    {
        IQueryResult<CommissionSearch> Search(ISearchCriteria criteria);
    }
}