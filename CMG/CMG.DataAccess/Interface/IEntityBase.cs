using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.DataAccess.Interface
{
    public interface IEntityBase : IEntity
    {
        public DateTime Cr8Date { get; set; }
        public string Cr8Locn { get; set; }
        public DateTime RevDate { get; set; }
        public string RevLocn { get; set; }
        public bool? Del { get; set; }
    }
}
