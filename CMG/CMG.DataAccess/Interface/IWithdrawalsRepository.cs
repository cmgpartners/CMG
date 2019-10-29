using CMG.DataAccess.Domain;
using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Interface
{
    public interface IWithdrawalsRepository : IRepository<Withd>
    {
        IQueryResult<Withd> Find(ISearchCriteria criteria);
    }
}
