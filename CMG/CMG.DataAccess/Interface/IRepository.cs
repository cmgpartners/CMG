using System.Threading.Tasks;

namespace CMG.DataAccess.Interface
{
    public interface IRepository<TEntity>
    {
        Task<TEntity> Save(TEntity entity);
        Task<TEntity> Add(TEntity entity);
        void Delete(TEntity entity);
    }
}
