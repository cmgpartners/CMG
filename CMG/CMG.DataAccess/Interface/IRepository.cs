using System.Collections.Generic;
using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IRepository<TEntity>
    {
        Task<TEntity> Save(TEntity entity);
        TEntity Add(TEntity entity);
        void Delete(TEntity entity);
        ICollection<TEntity> All();
    }

    public interface IQueryResult<TEntity>
    {
        int TotalRecords { get; set; }
        ICollection<TEntity> Result { get; set; }

        public decimal TotalAmount { get; set; }
    }

    public class PagedQueryResult<TEntity> : IQueryResult<TEntity>
    {
        public decimal TotalAmount { get; set; }
        public int TotalRecords { get; set; }
        public ICollection<TEntity> Result { get; set; }
    }
}
