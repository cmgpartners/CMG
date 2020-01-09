using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Windows.Input;
using static CMG.Common.Enums;
using System.Linq;
using ToastNotifications;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using CMG.DataAccess.Domain;
using Microsoft.Extensions.Caching.Memory;
using Newtonsoft.Json;

namespace CMG.Application.ViewModel
{
    public class MainViewModel : BaseViewModel
    {
        #region MemberVariables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IMemoryCache _memoryCache;
        private readonly Notifier _notifier;
        private Dictionary<string, bool> searchOptions;
        private const string optionsCacheKey = "options";
        private const string searchOptionsKey = "searchOptions";
        
        #endregion MemberVariables

        #region Constructor
        public MainViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, Notifier notifier = null)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _memoryCache = memoryCache;
            _notifier = notifier;
            GetUserOptions();
        }
     
        #endregion Constructor

        #region Properties
        private object selectedViewModel;
        public object SelectedViewModel
        {
            get { return selectedViewModel; }

            set { selectedViewModel = value; OnPropertyChanged("SelectedViewModel"); }
        }

        private int selectedIndexLeftNavigation;
        public int SelectedIndexLeftNavigation
        {
            get { return selectedIndexLeftNavigation; }
            set { selectedIndexLeftNavigation = value; OnPropertyChanged("SelectedIndexLeftNavigation"); }
        }

        private ViewCommissionDto _copiedCommission;
        public ViewCommissionDto CopiedCommission
        {
            get { return _copiedCommission; }
            set
            {
                _copiedCommission = value;
                OnPropertyChanged("CopiedCommission");
            }
        }

        private List<string> _companyNames;
        public List<string> CompanyNames
        {
            get { return _companyNames; }
            set { _companyNames = value; }
        }
        private List<ViewComboDto> _clientTypeCollection;
        public List<ViewComboDto> ClientTypeCollection
        {
            get { return _clientTypeCollection; }
            set { _clientTypeCollection = value; }
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

        public bool IsLastNameVisible
        {
            get { return IsSearchFieldVisible("LastName") ?? true; }
        }
        public bool IsFirstNameVisible
        {
            get { return IsSearchFieldVisible("FirstName") ?? true; }
        }
        public bool IsCommonNameVisible
        {
            get { return IsSearchFieldVisible("CommanName") ?? true; }
        }
        public bool IsPolicyNumberVisible
        {
            get { return IsSearchFieldVisible("PolicyNumber") ?? false; }
        }
        public bool IsClientSelected
        {
            get { return SelectedClient != null ? true : false; }
        }
        public bool IsPolicyDetailVisible
        {
            get { return SelectedClient == null ? true : false; }
        }
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
                PolicyViewModel pv = new PolicyViewModel(_unitOfWork, _mapper, SelectedClient);
                PolicyCollection = pv.PolicyCollection;
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
        #endregion Properties

        #region Methods
        public ICommand SearchPolicyCommand
        {
            get
            {
                return CreateCommand(SearchPolicy);
            }
        }
        public ICommand SearchCompanyCommand
        {
            get
            {
                return CreateCommand(SearchCompany);
            }
        }
        public ICommand SearchAgentCommand
        {
            get { return CreateCommand(SearchAgent); }
        }
        public ICommand SearchInsuredCommand
        {
            get
            {
                return CreateCommand(SearchInsured);
            }
        }
        public ICommand CopySearchedRecordCommand
        {
            get { return CreateCommand(CopySearchedRecord); }
        }
        public void SearchPolicy(object parameter)
        {
            if (parameter != null)
            {
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper, _notifier);
                searchViewModel.PolicyNumber = parameter.ToString().Trim();
                searchViewModel.Search(false);
                SelectedViewModel = searchViewModel;
                SelectedIndexLeftNavigation = (int)LeftNavigation.Search; 
            }
        }
        public void SearchCompany(object parameter)
        {
            if(parameter != null)
            {
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper, _notifier);
                searchViewModel.Company = parameter.ToString().Trim();
                searchViewModel.Search(false);
                SelectedViewModel = searchViewModel;
                SelectedIndexLeftNavigation = (int)LeftNavigation.Search;
            }
        }
        public void SearchInsured(object parameter)
        {
            if (parameter != null)
            {
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper, _notifier);
                searchViewModel.Insured = parameter.ToString().Trim();
                searchViewModel.Search(false);
                SelectedViewModel = searchViewModel;
                SelectedIndexLeftNavigation = (int)LeftNavigation.Search;
            }
        }
        public void SearchAgent(object parameter)
        {
            if (parameter != null)
            {
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper, _notifier);
                searchViewModel.Agent = parameter as ViewAgentDto;
                searchViewModel.SelecteAgentIndex = searchViewModel.AgentList.IndexOf(searchViewModel.AgentList.Where(X => X.Id == searchViewModel.Agent.Id).FirstOrDefault());
                searchViewModel.Search(true);
                SelectedViewModel = searchViewModel;
                SelectedIndexLeftNavigation = (int)LeftNavigation.Search;
            }
        }
        public void CopySearchedRecord(object parameter)
        {
            if(parameter != null)
            {
                RenewalsViewModel renewalsViewModel = new RenewalsViewModel(_unitOfWork, _mapper);
                renewalsViewModel.Copy(parameter);
                CopiedCommission = renewalsViewModel.CopiedCommission;
            }
        }

        public void GetUserOptions()
        {
            
            if(_memoryCache != null)
            {
                List<Options> options = default;
                if (!_memoryCache.TryGetValue(optionsCacheKey, out options))
                {
                    options = _unitOfWork.Options.All().Where(o => o.User == System.Environment.UserName).ToList();
                    _memoryCache.Set(optionsCacheKey, options);
                }
                var searchOptionsValue = options.Where(o => o.Key == searchOptionsKey).FirstOrDefault()?.Value;
                searchOptions = searchOptionsValue != null ? JsonConvert.DeserializeObject<Dictionary<string, bool>>(searchOptionsValue) : default;
            }
        }

        public bool? IsSearchFieldVisible(string field)
        {
            if (searchOptions != null && searchOptions.Count > 0)
            {
                if (searchOptions.ContainsKey(field))
                {
                    return searchOptions[field];
                }
            }
            return null;
        }
        #endregion Methods
    }
}
