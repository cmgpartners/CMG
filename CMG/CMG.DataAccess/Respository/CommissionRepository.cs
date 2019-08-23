using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace CMG.DataAccess.Respository
{
    public class CommissionRepository : Repository<Comm>, ICommissionRepository
    {
        public CommissionRepository(pb2Context context) : base(context)
        {
        }

        public Task<Comm> Add(Comm entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(Comm entity)
        {
            throw new NotImplementedException();
        }

        public Task<Comm> Save(Comm entity)
        {
            throw new NotImplementedException();
        }
    }
}
