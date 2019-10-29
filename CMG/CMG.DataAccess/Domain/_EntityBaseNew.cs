using CMG.DataAccess.Interface;
using System;
namespace CMG.DataAccess.Domain
{
    public class EntityBaseNew : Entity, IEntityBaseNew
    {
        public string CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public string ModifiedBy { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public bool IsDeleted { get; set; }
    }
}
