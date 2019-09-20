using CMG.DataAccess.Domain;

namespace CMG.DataAccess.Interface
{
    public interface ICommissionSearchRepository : IRepository<Commission>
    {
        IQueryResult<CommissionSearch> Search(ISearchCriteria criteria);
    }
}