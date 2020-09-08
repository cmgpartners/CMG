using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPolicyChangeRepository : IRepository<PolChg>
    {
        ICollection<PolChg> Find(int KeyNumo);
        ICollection<PolChg> FindClientHistory(int keyNump);
        PolChg FindHistory(int keyChgs);
        int GetNextId();
    }
}
