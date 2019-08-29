using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.Linq;

namespace CMG.DataAccess.Respository
{
    public class CommissionRepository : Repository<Comm>, ICommissionRepository
    {
        private readonly pb2Context _context;

        public CommissionRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
