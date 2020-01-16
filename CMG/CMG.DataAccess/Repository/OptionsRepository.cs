using System;
using System.Collections.Generic;
using System.Text;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
namespace CMG.DataAccess.Repository
{
    public class OptionsRepository : Repository<Options>, IOptionsRepository
    {
        private readonly pb2Context _context;

        public OptionsRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
    }
}
