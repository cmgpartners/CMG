using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPeopleRelationRepository: IRepository<RelPp>
    {
        ICollection<People> GetById(long? id);
    }
}
