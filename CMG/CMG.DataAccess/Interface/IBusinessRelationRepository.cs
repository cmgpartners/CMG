using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IBusinessRelationRepository : IRepository<RelBp>
    {
        ICollection<Business> GetById(long? id);
    }
}
