﻿using CMG.DataAccess.Domain;

namespace CMG.DataAccess.Interface
{
    public interface IPeopleRepository : IRepository<People>
    {
        IQueryResult<People> Find(ISearchCriteria criteria);
    }
}