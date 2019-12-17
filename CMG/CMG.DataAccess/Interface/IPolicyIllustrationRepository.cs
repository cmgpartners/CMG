using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPolicyIllustrationRepository : IRepository<PolIll>
    {
        List<PolIll> GetPolicyIllustration(int keynumo);
    }
}
