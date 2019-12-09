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

        private const string comboFieldNameClientType = "CLIENTTYP";
        private const string comboFieldNamePolicyType = "TYPE";
        private const string comboFieldNameFrequency = "FREQUENCY";
        private const string comboFieldNameStatus = "STATUS";
        private const string comboFieldNameCompany = "COMPANY";
        private const string comboFieldNamePStatus = "PSTATUS";
        private const string comboFieldNameSVCType = "SVC_TYPE";
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

        private List<ViewComboDto> _clientTypeCollection;
        public List<ViewComboDto> ClientTypeCollection
        {
            get { return _clientTypeCollection; }
            set {_clientTypeCollection = value;}
        }

        private List<ViewComboDto> _policyTypeCollection;
        public List<ViewComboDto> PolicyTypeCollection
        {
            get { return _policyTypeCollection; }
            set { _policyTypeCollection = value; }
        }

        private List<ViewComboDto> _frequencyTypeCollection;
        public List<ViewComboDto> FrequencyTypeCollection
        {
            get { return _frequencyTypeCollection; }
            set { _frequencyTypeCollection = value; }
        }
        
        private List<ViewComboDto> _statusTypeCollection;
        public List<ViewComboDto> StatusTypeCollection
        {
            get { return _statusTypeCollection; }
            set { _statusTypeCollection = value; }
        }

        private List<ViewComboDto> _companyCollection;
        public List<ViewComboDto> CompanyCollection
        {
            get { return _companyCollection; }
            set { _companyCollection = value; }
        }
        private List<ViewComboDto> _personStatusCollection;
        public List<ViewComboDto> PersonStatusCollection
        {
            get { return _personStatusCollection; }
            set { _personStatusCollection = value; }
        }
        private List<ViewComboDto> _svcTypeCollection;
        public List<ViewComboDto> SVCTypeCollection
        {
            get { return _svcTypeCollection; }
            set { _svcTypeCollection = value; }
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
                OnPropertyChanged("SelectedClient");
                GetPolicyCollection();
            }
        }

        private ViewPolicyListDto _selectedPolicy;
        public ViewPolicyListDto SelectedPolicy
        {
            get { return _selectedPolicy; }
            set
            {
                _selectedPolicy = value;
                OnPropertyChanged("SelectedPolicy");
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
            get { return CreateCommand(Search); }
        }
        #endregion command properties
        #endregion Properties

        #region Methods
        private void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
            ClientTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameClientType).ToList();
            PolicyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePolicyType).ToList();
            FrequencyTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameFrequency).ToList();
            StatusTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameStatus).ToList();
            CompanyCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCompany).ToList();
            PersonStatusCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePStatus).ToList();
            SVCTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameSVCType).ToList();
        }
       
        private void LoadData()
        {
            GetComboData();
            GetPolicies();
        }
        
        private void SearchByPolicyNumber()
        {
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> searchBy = new List<FilterBy>();
            FilterBy filterBy = new FilterBy();
            filterBy.Property = "policynumber";
            filterBy.Equal = "N065700T"; //"3473188" - 3 records will come
            searchBy.Add(filterBy);
            searchQuery.FilterBy = searchBy;

            var policyTemp = _unitOfWork.Policies.Find(searchQuery);
            searchQuery = new SearchQuery();
            searchBy = new List<FilterBy>();
            filterBy = new FilterBy();
            List<string> keynumpList = policyTemp.Result.FirstOrDefault().PeoplePolicys.ToList().Where(c => c.Keynump > 0).Select(x => x.Keynump.ToString()).ToList();

            searchBy.Add(FilterByIn("keynump", string.Join(",", keynumpList)));
            searchQuery.FilterBy = searchBy;
            var dataSearchBy = _unitOfWork.People.Find(searchQuery);
            var dataCollection = dataSearchBy.Result.Select(x => { x.Clienttyp = string.IsNullOrEmpty(x.Clienttyp.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.Clienttyp.Trim()).FirstOrDefault().Description; return x; });
            ClientCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());
        }
        private void Search()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.People.Find(searchQuery);
            var dataCollection = new ObservableCollection<ViewClientSearchDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());

            ClientCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(x => {
                                    x.ClientType = string.IsNullOrEmpty(x.ClientType.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.ClientType.Trim()).FirstOrDefault().Description;
                                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : PersonStatusCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault().Description;
                                    x.SVCType = string.IsNullOrEmpty(x.SVCType.Trim()) ? "" : SVCTypeCollection.Where(c => c.FieldCode == x.SVCType.Trim()).FirstOrDefault().Description;
                                    return x;
                                }));
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
                BuildFilterByEquals("EntityType", SelectedClientType.FieldCode.Trim(), searchBy);
            }

            searchQuery.FilterBy = searchBy;
            return searchQuery;
        }
        private FilterBy FilterByIn(string propertyName, string value)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.In = value;
            return filterBy;
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
            if (SelectedClient != null)
            {
                SearchQuery searchQuery = new SearchQuery();
                List<FilterBy> searchBy = new List<FilterBy>();
                BuildFilterByEquals("keynump", SelectedClient.Keynump.ToString(), searchBy);
                searchQuery.FilterBy = searchBy;

                var dataSearchBy = _unitOfWork.Policies.Find(searchQuery);

                var policyCollection = (dataSearchBy.Result.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList());

                PolicyCollection = new ObservableCollection<ViewPolicyListDto>(policyCollection.Select(x =>
                {
                    x.Type = string.IsNullOrEmpty(x.Type.Trim()) ? "" : PolicyTypeCollection.Where(c => c.FieldCode == x.Type.Trim()).FirstOrDefault().Description;
                    x.Frequency = string.IsNullOrEmpty(x.Frequency.Trim()) ? "" : FrequencyTypeCollection.Where(c => c.FieldCode == x.Frequency.Trim()).FirstOrDefault().Description;
                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : StatusTypeCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault().Description;
                    x.CompanyName = string.IsNullOrEmpty(x.CompanyName.Trim()) ? "" : CompanyCollection.Where(c => c.FieldCode == x.CompanyName.Trim()).FirstOrDefault().Description;
                    return x;
                }));

                if(PolicyCollection.Count > 0)
                {
                    SelectedPolicy = PolicyCollection[0];
                }
            }
        }
        #endregion Methods
    }
}
