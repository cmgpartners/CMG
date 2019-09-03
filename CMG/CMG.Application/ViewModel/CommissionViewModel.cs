using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Collections.ObjectModel;
using System.Linq;
using AutoMapper;
using System.Globalization;
using System.Collections.Generic;
using System;

namespace CMG.Application.ViewModel
{
    public class CommissionViewModel : Profile
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        #endregion Member variables

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
                return Enumerable.Range(startYear, CurrentYear + 1 - startYear).ToList();
            }
        }

        public int CurrentYear
        {
            get
            {
                return DateTime.Now.Year;
            }
        }

        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set { _dataCollection = value; }
        }

        #endregion Properties

        #region Constructor
        public CommissionViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            DataCollection = new ObservableCollection<ViewCommissionDto>();
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        #endregion Constructor

        #region Methods
        public async void GetAllCommission()
        {
            var dataCommissiosns = await _unitOfWork.Commissions.All();
            _dataCollection = new ObservableCollection<ViewCommissionDto>(dataCommissiosns.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
        }
        #endregion Methods
    }
}
