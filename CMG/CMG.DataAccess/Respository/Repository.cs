using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace CMG.DataAccess.Respository
{
    public class Repository<TEntity> : IRepository<TEntity> where TEntity : EntityBase
    {
        protected pb2Context Context { get; }

        public Repository(pb2Context context)
        {
            Context = context;
        }
        public System.Threading.Tasks.Task<TEntity> Add(TEntity entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(TEntity entity)
        {
            throw new NotImplementedException();
        }

        public System.Threading.Tasks.Task<TEntity> Save(TEntity entity)
        {
            throw new NotImplementedException();
        }
    }
}
