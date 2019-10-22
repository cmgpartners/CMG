using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore.ChangeTracking;
using System;
using System.ComponentModel.DataAnnotations;

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
            var entry = Context.Entry(entity);
            var key = this.GetPrimaryKey(entry);

            if (entry.State == EntityState.Detached)
            {
                var currentEntry = Context.Set<TEntity>().Find(key);
                if (currentEntry != null)
                {
                    var attachedEntry = Context.Entry(currentEntry);
                    attachedEntry.CurrentValues.SetValues(entity);
                }
                else
                {
                    Context.Set<TEntity>().Attach(entity);
                    entry.State = EntityState.Modified;
                }
            }
            return entity;
        }

        public ICollection<TEntity> All()
        {
            return Context.Set<TEntity>().ToList();
        }

        private int GetPrimaryKey(EntityEntry entry)
        {
            var myObject = entry.Entity;
            var property =
                myObject.GetType()
                    .GetProperties()
                    .FirstOrDefault(prop => Attribute.IsDefined(prop, typeof(KeyAttribute)));
            return property != null ? (int)property.GetValue(myObject, null) : 0;
        }
        #endregion Methods
    }
}
