using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using System.Collections.Generic;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using System.Data.Common;
using System.Data.SqlClient;

namespace CMG.DataAccess.Repository
{
    public class PolicyChangeRepository : Repository<PolChg>, IPolicyChangeRepository
    {
        private readonly pb2Context _context;

        public PolicyChangeRepository(pb2Context context) : base(context)
        {
            _context = context;
        }
        public ICollection<PolChg> Find(int keyNumo)
        {
            var result = _context.PolChg.Where(p => p.Keynumo == keyNumo && p.Del == false).ToList();
            return result;
        }
        public PolChg FindHistory(int keyChgs)
        {
            return _context.PolChg.Where(p => p.Keychgs == keyChgs && p.Del == false).FirstOrDefault();
        }
        public ICollection<PolChg> FindClientHistory(int keyNump)
        {
            DbParameter peopleId = new SqlParameter("keynump", keyNump);
            IQueryable<PolChg> query = _context.PolChg.FromSql("SELECT * from POL_CHG PC WHERE (KEYNUMO IN " +
                                                "(SELECT DISTINCT KEYNUMO FROM PEOPLE_POLICYS " +
                                                $"WHERE BUS = 0 AND DEL_ = 0 and KEYNUMP > 0 and KEYNUMP = @keynump)" +
                                                $"OR(PC.KEYNUMP > 0 AND PC.KEYNUMP = @keynump AND DEL_ = 0)) AND PC.DEL_ = 0", peopleId);

            return query.ToList().OrderByDescending(c => c.EffDate).ToList();
        }
        public int GetNextId()
        {
            return (_context.PolChg.OrderByDescending(p => p.Keychgs).Take(1).FirstOrDefault().Keychgs) + 1;
        }
    }
}
