using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IRepository<TEntity>
    {
        Task<TEntity> Save(TEntity entity);
        Task<TEntity> Add(TEntity entity);
        void Delete(TEntity entity);
        Task<ICollection<TEntity>> All();
    }

    public interface IQueryResult<TEntity>
    {
        int TotalRecords { get; set; }
        ICollection<TEntity> Result { get; set; }
    }

    public class PagedQueryResult<TEntity> : IQueryResult<TEntity>
    {
        public int TotalRecords { get; set; }
        public ICollection<TEntity> Result { get; set; }
    }
}
