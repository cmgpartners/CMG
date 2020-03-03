using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IBusinessPolicyRepository : IRepository<BusinessPolicys>
    {
        BusinessPolicys GetById(long? relationshipId);
        public int GetMaxKeynum();
    }
}
