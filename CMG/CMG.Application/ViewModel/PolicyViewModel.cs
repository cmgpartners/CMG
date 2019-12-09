using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using CMG.Service.Interface;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;
using ToastNotifications;

namespace CMG.Application.ViewModel
{
    public class PolicyViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        private readonly Notifier _notifier;

        private const string comboFieldNameClentType = "CLIENTTYP";
        #endregion

        #region Constructor
        public PolicyViewModel(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null, Notifier notifier = null) 
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
            LoadData();
        }
        #endregion Constructor

        #region Properties
        private ObservableCollection<ViewClientSearchDto> _clientCollection;
        public ObservableCollection<ViewClientSearchDto> ClientCollection
        {
            get { return _clientCollection; }
            set
            {
                _clientCollection = value;
                OnPropertyChanged("ClientCollection");
                OnPropertyChanged("IsPaginationVisible");
            }
        }

        private ObservableCollection<ViewPolicyListDto> _policyCollection;
        public ObservableCollection<ViewPolicyListDto> PolicyCollection
        {
            get { return _policyCollection; }
            set
            {
                _policyCollection = value;
                OnPropertyChanged("PolicyCollection");
            }
        }

        private List<ViewComboDto> _combo;
        public List<ViewComboDto> Combo
        {
            get { return _combo; }
            set { _combo = value; }
        }

        private ObservableCollection<ViewComboDto> _clientTypeCollection;
        public ObservableCollection<ViewComboDto> ClientTypeCollection
        {
            get { return _clientTypeCollection; }
            set
            {
                _clientTypeCollection = value;
                OnPropertyChanged("ClientTypeCollection");
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

        private ViewClientSearchDto _selectedClient;
        public ViewClientSearchDto SelectedClient
        {
            get { return _selectedClient; }
            set 
            { 
                _selectedClient = value;
                OnPropertyChanged("Policies");
                GetPolicyCollection();
            }
        }

        private ViewComboDto _selectedClientType;
        public ViewComboDto SelectedClientType
        {
            get { return _selectedClientType; }
            set
            {
                _selectedClientType = value;
                OnPropertyChanged("SelectedClientType");
            }
        }

        private string _commanName;
        public string CommanName
        {
            get
            {
                return _commanName;
            }
            set
            {
                _commanName = value;
                OnPropertyChanged("CommanName");
            }
        }
        
        private string _firstName;
        public string FirstName
        {
            get
            {
                return _firstName;
            }
            set
            {
                _firstName = value;
                OnPropertyChanged("FirstName");
            }
        }

        private string _lastName;
        public string LastName
        {
            get
            {
                return _lastName;
            }
            set
            {
                _lastName = value;
                OnPropertyChanged("LastName");
            }
        }

        private string _policyNumber;
        public string PolicyNumber
        {
            get { return _policyNumber; }
            set
            {
                _policyNumber = value;
                OnPropertyChanged("PolicyNumber");
            }
        }

        private string _companyName;
        public string CompanyName
        {
            get { return _companyName; }
            set
            {
                _companyName = value;
                OnPropertyChanged("CompanyName");
            }
        }
        
        private DateTime? _fromDate;
        public DateTime? FromDate
        {
            get { return _fromDate; }
            set
            {
                _fromDate = value;
                OnPropertyChanged("FromDate");
            }
        }
        private DateTime? _toDate;
        public DateTime? ToDate
        {
            get { return _toDate; }
            set
            {
                _toDate = value;
                OnPropertyChanged("ToDate");
            }
        }

        #region command properties
        public ICommand SearchClientCommand
        {
            get { return CreateCommand(Search); }//Search
        }
        #endregion command properties
        #endregion Properties

        #region Methods
        private void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
        }
        private void GetClientType()
        {
            ClientTypeCollection = new ObservableCollection<ViewComboDto>(Combo.Where(x => x.FieldName.Trim() == comboFieldNameClentType).ToList());
        }
        private void LoadData()
        {
            GetComboData();
            GetClientType();
            GetPolicies();
        }

        private void Search()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.People.Find(searchQuery);
            var dataCollection = dataSearchBy.Result.Select(x => { x.Clienttyp = string.IsNullOrEmpty(x.Clienttyp.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.Clienttyp.Trim()).FirstOrDefault().Description; return x; });
            ClientCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());
        }
        private SearchQuery BuildSearchQuery()
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            if (!string.IsNullOrEmpty(FirstName))
            {
                BuildFilterByContains("FirstName", FirstName, searchBy);
            }
            if (!string.IsNullOrEmpty(LastName))
            {
                BuildFilterByContains("LastName", LastName, searchBy);
            }
            if (!string.IsNullOrEmpty(CommanName))
            {
                BuildFilterByContains("Commonname", CommanName, searchBy);
            }
            if (SelectedClientType != null)
            {
                BuildFilterByEquals("EntityType", SelectedClientType.FieldCode, searchBy);
            }

            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }
        private void BuildFilterByContains(string property, string value, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Contains = value;
            searchBy.Add(filterBy);
        }

        private void BuildFilterByEquals(string property, string value, List<FilterBy> searchBy)
        {
            value = ClientTypeCollection.Where(x => x.FieldCode.Trim() == value.Trim()).FirstOrDefault().FieldCode.Trim();
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.Equal = value;
            searchBy.Add(filterBy);
        }
        private void BuildFilterByRange(string property, string fromvalue, string toValue, List<FilterBy> searchBy)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = property;
            filterBy.GreaterThan = fromvalue;
            filterBy.LessThan = toValue;
            searchBy.Add(filterBy);
        }
        private void GetPolicies()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).AsEnumerable();
        }
        private void GetPolicyCollection()
        {

        }
        #endregion Methods
    }
}
