using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Interface
{
    public interface IEntityBaseNew : IEntity
    {
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public bool IsDeleted { get; set; }
    }
}
