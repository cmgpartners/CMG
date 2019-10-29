using AutoMapper;
using CMG.DataAccess.Interface;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;

namespace CMG.Application.ViewModel
{
    public class FinanceSummaryViewModel : MainViewModel
    {

        #region Member variables
        private readonly IUnitOfWork _unitOfWork; 
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        #endregion Member variables

        #region Constructor
        public FinanceSummaryViewModel(IUnitOfWork unitOfWork, IMapper mapper)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        #endregion Constructor

        #region Properties
        public ICollection<string> Months
        {
            get
            {
                return DateTimeFormatInfo.CurrentInfo.MonthNames.Where(t => t.Length > 0).Select(m => m.Substring(0, 3)).ToList();
            }
        }

        public ICollection<int> Years
        {
            get
            {
                return Enumerable.Range(startYear, DateTime.Now.Year + 1 - startYear).ToList();
            }
        }

        private int _selectedYear = DateTime.Now.Year;
        public int SelectedYear
        {
            get { return _selectedYear; }
            set
            {
                _selectedYear = value;
                OnPropertyChanged("SelectedYear");
                //GetCommissions();
            }
        }
        #endregion Properties


        #region Methods

        #endregion Methods
    }
}
