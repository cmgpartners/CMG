using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;

namespace CMG.Application.ViewModel
{
    public class PolicyViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion

        #region Constructor
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper) 
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            LoadData();
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
        private IEnumerable<string> _policies;
        public IEnumerable<string> Policies
        {
            get { return _policies; }
            set
            {
                _policies = value;
                OnPropertyChanged("Policies");
            }
        }

        private IEnumerable<ViewComboDto> _clientType;
        public IEnumerable<ViewComboDto> ClientType
        {
            get { return _clientType;  }
            set { _clientType = value; }
        }

        private IEnumerable<string> _clientTypeDescription;
        public IEnumerable<string> ClientTypeDescription
        {
            get { return _clientTypeDescription; }
            set { _clientTypeDescription = value; }
        }
        #endregion

        #region Methods
        private void GetAllPolicy()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            DataCollection = new ObservableCollection<ViewPolicyListDto>(policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList());
        }
        private void GetPolicies()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).AsEnumerable();
        }
        private void GetClientTypes()
        {
            var combo = _unitOfWork.Combo.All();
            ClientType =combo.Where(x => x.FIELDNAME.Trim() == "CLIENTTYP").Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
            ClientTypeDescription = ClientType.Select(c => c.Description).AsEnumerable();
        }
        public void LoadData()
        {
            GetAllPolicy();
            GetPolicies();
            GetClientTypes();
        }
        #endregion Methods
    }
}
