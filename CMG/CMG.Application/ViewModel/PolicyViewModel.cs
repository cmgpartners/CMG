using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Collections.ObjectModel;
using System.Linq;

namespace CMG.Application.ViewModel
{
    public class PolicyViewModel : BaseViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            GetAllPolicy();
        }
        #endregion Constructor

        #region Properties
        private ObservableCollection<ViewPolicyListDto> _dataCollection;
        public ObservableCollection<ViewPolicyListDto> DataCollection
        {
            get { return _dataCollection; }
            set
            {
                _dataCollection = value;
                OnPropertyChanged("DataCollection");
                OnPropertyChanged("IsPaginationVisible");
            }
        }
        #endregion

        #region Methods
        private void GetAllPolicy()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            DataCollection = new ObservableCollection<ViewPolicyListDto>(policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList());
        }
        #endregion Methods
    }
}
