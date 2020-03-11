using System;
using System.Collections.Generic;
using System.Text;

namespace CMG.Application.DTO
{
    public class ViewFilesDto
    {
        public string Name { get; set; }
        public string Path { get; set; }
        public string IconType { get; set; }
        public int Size { get; set; }
        public DateTime ModifiedDateTime { get; set; }
    }
}
