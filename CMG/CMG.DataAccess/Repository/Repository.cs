using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;

namespace CMG.DataAccess.Repository
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : EntityBase
    {
        #region Constructor
        public Repository(pb2Context context)
        {
            Context = context;
        }
        #endregion Constructor

        #region Properties
        protected pb2Context Context { get; }
        #endregion Properties

        #region Methods
        public virtual TEntity Add(TEntity entity)
        {
            var result = Context.Set<TEntity>().Add(entity);
            return result.Entity;
        }

        public void Delete(TEntity entity)
        {
            Context.Set<TEntity>().Remove(entity);
        }

        public TEntity Save(TEntity entity)
        {
            Context.Entry(entity).State = EntityState.Modified;
            return entity;
        }

        public ICollection<TEntity> All()
        {
            return Context.Set<TEntity>().ToList();
        }   
        #endregion Methods
    }
}
