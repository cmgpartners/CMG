﻿using CMG.DataAccess.Domain;
using System.Collections.Generic;

namespace CMG.DataAccess.Interface
{
    public interface IPolicyRepository : IRepository<Policys>
    {
        ICollection<Policys> GetAllPolicyNumber();
    }
}