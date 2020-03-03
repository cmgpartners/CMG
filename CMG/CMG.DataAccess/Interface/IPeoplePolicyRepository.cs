using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPeoplePolicyRepository : IRepository<PeoplePolicys>
    {
        PeoplePolicys GetById(long? relationshipId);
        public int GetMaxKeynuml();
    }
}
