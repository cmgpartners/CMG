using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Linq.Expressions;
using LinqKit;
using System.Collections.Generic;

namespace CMG.DataAccess.Repository
{
    public class PolicyIllustrationRepository : Repository<PolIll>, IPolicyIllustrationRepository
    {
        private readonly pb2Context _context;

        public PolicyIllustrationRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public List<PolIll> GetPolicyIllustration(int keynumo, int dividentScale)
        {
            return Context.PolIll.Where(x => x.Keynumo == keynumo && x.Divscale == dividentScale).ToList();
        }
        public PolIll GetById(long? id)
        {
            return Context.PolIll.SingleOrDefault(x => x.Id == (id ?? 0));
        }
    }
}
