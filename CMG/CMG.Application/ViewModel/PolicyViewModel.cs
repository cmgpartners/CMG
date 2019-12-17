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
using ToastNotifications.Messages;

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
        private const string comboFieldNameCategory = "CATGRY";
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

        private ObservableCollection<ViewPolicyIllustrationDto> _policyIllustrationCollection;
        public ObservableCollection<ViewPolicyIllustrationDto> PolicyIllustrationCollection
        {
            get { return _policyIllustrationCollection; }
            set
            {
                _policyIllustrationCollection = value;
                OnPropertyChanged("PolicyIllustrationCollection");
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
        private List<string> _companyNames;
        public List<string> CompanyNames
        {
            get { return _companyNames; }
            set { _companyNames = value; }
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
        private List<ViewComboDto> _categoryCollection;
        public List<ViewComboDto> CategoryCollection
        {
            get { return _categoryCollection; }
            set { _categoryCollection = value; }
        }
	    private List<string> _policies;
        public List<string> Policies
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
                OnPropertyChanged("IsClientSelected");
                OnPropertyChanged("IsPolicyDetailVisible");
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
        
        private ViewPolicyIllustrationDto _selectedIllustration;
        public ViewPolicyIllustrationDto SelectedIllustration
        {
            get { return _selectedIllustration; }
            set
            {
                _selectedIllustration = value;
                OnPropertyChanged("SelectedIllustration");
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
        public bool IsClientSelected
        {
            get { return SelectedClient != null ? true : false ; }
        }

        public bool IsPolicyDetailVisible
        {
            get { return SelectedClient == null ? true : false; }
        }
       
        #region command properties
        public ICommand SearchClientCommand
        {
            get { return CreateCommand(Search); }
        }
        public ICommand ViewIllustrationCommand
        {
            get { return CreateCommand(ViewIllustration);  }
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
            CompanyNames = CompanyCollection.Select(x => x.Description.Trim()).ToList();
            PersonStatusCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePStatus).ToList();
            SVCTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameSVCType).ToList();
            CategoryCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCategory).ToList();
        }
        private void LoadData()
        {
            GetComboData();
            GetPolicies();
        }        
        private void Search()
        {
            if (IsValidSearchCriteria())
            {
                SearchQuery searchQuery = BuildSearchQuery();
                var dataSearchBy = _unitOfWork.People.Find(searchQuery);
                var dataCollection = new ObservableCollection<ViewClientSearchDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());

            ClientCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(x => {
                                    x.ClientType = string.IsNullOrEmpty(x.ClientType.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.ClientType.Trim()).FirstOrDefault()?.Description;
                                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : PersonStatusCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault()?.Description;
                                    x.SVCType = string.IsNullOrEmpty(x.SVCType.Trim()) ? "" : SVCTypeCollection.Where(c => c.FieldCode == x.SVCType.Trim()).FirstOrDefault()?.Description;
                    return x;
                }));
            }
        }

        private bool IsValidSearchCriteria()
        {
            bool isValid = true;
            if(string.IsNullOrEmpty(CompanyName)
                && string.IsNullOrEmpty(PolicyNumber))
            {
                isValid = false;
                _notifier.ShowError("Enter valid information to search client");
            }

            if (isValid)
            {
                if (!string.IsNullOrEmpty(CompanyName))
                {
                    isValid = CompanyNames.Any(x => x.ToLower().Equals(CompanyName.ToString().ToLower().Trim()));
                    if (!isValid)
                        _notifier.ShowError("Select valid company name");

                }
                if (!string.IsNullOrEmpty(PolicyNumber))
                {
                    isValid = Policies.Any(x => x.ToLower().Equals(PolicyNumber.ToLower().Trim()));
                    if (!isValid)
                        _notifier.ShowError("Select valid Policy number");

                }
            }

            return isValid;
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
            if (!string.IsNullOrEmpty(PolicyNumber))
            {
                BuildFilterByContains("PolicyNumber", PolicyNumber.Trim(), searchBy);
            }
            if (!string.IsNullOrEmpty(CompanyName))
            {
                var companyCode = CompanyCollection.Where(c => c.Description == CompanyName).FirstOrDefault()?.FieldCode;
                if (!string.IsNullOrEmpty(companyCode))
                {
                    BuildFilterByEquals("CompanyName", companyCode, searchBy);
                }
                else
                { 
                    //show error message company not exist
                }
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
            Policies = temppolicies.Select(r => r.PolicyNumber).ToList();
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
                    x.Type = string.IsNullOrEmpty(x.Type.Trim()) ? "" : PolicyTypeCollection.Where(c => c.FieldCode == x.Type.Trim()).FirstOrDefault()?.Description;
                    x.Frequency = string.IsNullOrEmpty(x.Frequency.Trim()) ? "" : FrequencyTypeCollection.Where(c => c.FieldCode == x.Frequency.Trim()).FirstOrDefault()?.Description;
                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : StatusTypeCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault()?.Description;
                    x.CompanyName = string.IsNullOrEmpty(x.CompanyName.Trim()) ? "" : CompanyCollection.Where(c => c.FieldCode == x.CompanyName.Trim()).FirstOrDefault()?.Description;
                    x.PeoplePolicy = x.PeoplePolicy.Select(
                        p =>
                        {
                            p.Category = string.IsNullOrEmpty(p.Category.Trim()) ? "" : CategoryCollection.Where(c => c.FieldCode == p.Category.Trim()).FirstOrDefault()?.Description;
                            return p;
                        }
                    ).ToList();
                    return x;
                }));

                if(PolicyCollection.Count > 0)
                {
                    SelectedPolicy = PolicyCollection[0];
                }
            }
        }

        private void ViewIllustration()
        {
            if(SelectedPolicy != null)
            {
                var policyIllustrations = _unitOfWork.PolicyIllustration.GetPolicyIllustration(SelectedPolicy.Id);
                PolicyIllustrationCollection = new ObservableCollection<ViewPolicyIllustrationDto>(policyIllustrations.Select(r => _mapper.Map<ViewPolicyIllustrationDto>(r))); 
                if(PolicyIllustrationCollection.Count > 0)
                {
                    SelectedIllustration = PolicyIllustrationCollection[0];
                }
            }
        }
        #endregion Methods
    }
}
