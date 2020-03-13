using System;
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
using CMG.DataAccess.Query;
using ToastNotifications.Messages;
using Newtonsoft.Json;
using System.Data;

namespace CMG.Application.ViewModel
{
    public class MainViewModel : BaseViewModel
    {
        #region MemberVariables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IMemoryCache _memoryCache;
        private readonly Notifier _notifier;
        private const string searchOptionsKey = "searchOptions";
        private const string PolicyColumnsKey = "policyColumns";
        private const string IllustrationColumnsKey = "illustrationColumns";
        private const string optionsCacheKey = "options";
        private const string comboFieldNamePStatus = "PSTATUS";
        private const string comboFieldNameSVCType = "SVC_TYPE";
        private const string comboFieldNameClientType = "CLIENTTYP";
        private const string comboFieldNameCompany = "COMPANY";
        private const string commissionAccessCacheKey = "CommissionAccess";

        private const string ColumnNamePolicyNumber = "Policy Number";
        private const string ColumnNameCompany = "Company";
        private const string ColumnNameFaceAmount = "Face Amount";
        private const string ColumnNamePayment = "Payment";
        private const string ColumnNameStatus = "Status";
        private const string ColumnNameFrequency = "Frequency";
        private const string ColumnNameType = "Type";
        private const string ColumnNamePlanCode = "Plan Code";
        private const string ColumnNameRating = "Rating";
        private const string ColumnNameClass = "Class";
        private const string ColumnNameCurrency = "Currency";
        private const string ColumnNamePolicyDate = "Policy Date";
        private const string ColumnNamePlacedOn = "Placed On";
        private const string ColumnNameReprojectedOn = "Reprojected On";
        private const string ColumnNamePolicyNotes = "Policy Notes";
        private const string ColumnNameClientNotes = "Client Notes";
        private const string ColumnNameInternalNotes = "Internal Notes";
        private const string ColumnNameAge = "Age";
        private const string ColumnNameInsured = "Insured";
        private const string ColumnNameBeneficiary = "Beneficiary";
        private const string ColumnNameOwner = "Owner";

        private const string ColumnNameYear = "Year";
        private const string ColumnNameAD = "AD";
        private const string ColumnNameADA = "ADA";
        private const string ColumnNameADR = "ADR";
        private const string ColumnNameCV = "CV";
        private const string ColumnNameCVA = "CVA";
        private const string ColumnNameCVR = "CVR";
        private const string ColumnNameDB = "DB";
        private const string ColumnNameDBA = "DBA";
        private const string ColumnNameDBR = "DBR";
        private const string ColumnNameACB = "ACB";
        private const string ColumnNameACBA = "ACBA";
        private const string ColumnNameACBR = "ACBR";
        private const string ColumnNameNCPI = "NCPI";
        private const string ColumnNameNCPIA = "NCPIA";
        private const string ColumnNameNCPIR = "NCPIR";
        #endregion MemberVariables

        #region Constructor
        public MainViewModel(IUnitOfWork unitOfWork, IMapper mapper, IMemoryCache memoryCache = null, Notifier notifier = null)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _memoryCache = memoryCache;
            _notifier = notifier;
            GetUserOptions();
            CheckCommissionAccess();
            LoadData();
        }

        #endregion Constructor

        #region Properties
        private ViewClientSearchDto _mainSelectedClient;
        public ViewClientSearchDto MainSelectedClient
        {
            get { return _mainSelectedClient; }
            set { _mainSelectedClient = value; }
        }
        private object selectedViewModel;
        public object SelectedViewModel
        {
            get { return selectedViewModel; }

            set { selectedViewModel = value; OnPropertyChanged("SelectedViewModel"); }
        }

        private int selectedIndexLeftNavigation = -1;
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

        private List<ViewComboDto> _clientTypeCollection;
        public List<ViewComboDto> ClientTypeCollection
        {
            get { return _clientTypeCollection; }
            set { _clientTypeCollection = value; OnPropertyChanged("ClientTypeCollection"); }
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
        private ViewComboDto _entityType;
        public ViewComboDto EntityType
        {
            get { return _entityType; }
            set
            {
                _entityType = value;
                OnPropertyChanged("EntityType");
            }
        }
        private ViewComboDto _companyName;
        public ViewComboDto CompanyName
        {
            get { return _companyName; }
            set
            {
                _companyName = value;
                OnPropertyChanged("CompanyName");
            }
        }
        private DateTime? _frompolicyDate;
        public DateTime? FromPolicyDate
        {
            get { return _frompolicyDate; }
            set { _frompolicyDate = value; OnPropertyChanged("FromPolicyDate"); }
        }

        private DateTime? _toPolicyDate;
        public DateTime? ToPolicyDate
        {
            get { return _toPolicyDate; }
            set { _toPolicyDate = value; OnPropertyChanged("ToPolicyDate"); }
        }

        private ObservableCollection<ViewSearchOptionsDto> _searchOptions;
        public ObservableCollection<ViewSearchOptionsDto> SearchOptions
        {
            get { return _searchOptions; }
            set 
            { 
                _searchOptions = value;
                OnPropertyChanged("SearchOptions");
            }
        }

        private ObservableCollection<ViewSearchOptionsDto> _policyColumns;
        public ObservableCollection<ViewSearchOptionsDto> PolicyColumns
        {
            get { return _policyColumns; }
            set
            {
                _policyColumns = value;
                OnPropertyChanged("PolicyColumns");
            }
        }
        private ObservableCollection<ViewSearchOptionsDto> _illustrationColumns;
        public ObservableCollection<ViewSearchOptionsDto> IllustrationColumns
        {
            get
            {
                return _illustrationColumns;
            }
            set
            {
                _illustrationColumns = value;
                OnPropertyChanged("IllustrationColumns");
            }
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
                OnPropertyChanged("IsNoClientRecord");
            }
        }
        public bool IsNoClientRecord
        {
            get
            {
                return ClientCollection != null && ClientCollection.Count == 0;
            }
        }
        private List<string> columnNames;
        public List<string> ColumnNames
        {
            get { return columnNames; }
            set
            {
                columnNames = value;
                OnPropertyChanged("ColumnNames");
            }
        }
        private List<string> _illustrationColumnNames;
        public List<string> IllustrationColumnNames
        {
            get
            {
                return _illustrationColumnNames;
            }
            set
            {
                _illustrationColumnNames = value;
                OnPropertyChanged("IllustrationColumnNames");
            }
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
        private List<ViewComboDto> _companyCollection;
        public List<ViewComboDto> CompanyCollection
        {
            get { return _companyCollection; }
            set { _companyCollection = value; }
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
        private List<ViewComboDto> _combo;
        public List<ViewComboDto> Combo
        {
            get { return _combo; }
            set { _combo = value; }
        }
        public bool HasCommissionAccess { get; set; }
        
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
        public ICommand SearchClientCommand
        {
            get { return CreateCommand(SearchClient); }
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
        public void LoadData()
        {
            GetComboData();
            GetAutoSuggestionLists();
            AddPolicyColumnsContextMenu();
            AddIllustrationColumnsContextMenu();
        }
        private void AddPolicyColumnsContextMenu()
        {
            ColumnNames = new List<string>();
            ColumnNames.Add(ColumnNamePolicyNumber);
            ColumnNames.Add(ColumnNameCompany);
            ColumnNames.Add(ColumnNameFaceAmount);
            ColumnNames.Add(ColumnNamePayment);
            ColumnNames.Add(ColumnNameStatus);
            ColumnNames.Add(ColumnNameFrequency);
            ColumnNames.Add(ColumnNameType);
            ColumnNames.Add(ColumnNamePlanCode);
            ColumnNames.Add(ColumnNameRating);
            ColumnNames.Add(ColumnNameClass);
            ColumnNames.Add(ColumnNameCurrency);
            ColumnNames.Add(ColumnNamePolicyDate);
            ColumnNames.Add(ColumnNamePlacedOn);
            ColumnNames.Add(ColumnNameReprojectedOn);
            ColumnNames.Add(ColumnNameAge);
            ColumnNames.Add(ColumnNamePolicyNotes);
            ColumnNames.Add(ColumnNameClientNotes);
            ColumnNames.Add(ColumnNameInternalNotes);
            ColumnNames.Add(ColumnNameInsured);
            ColumnNames.Add(ColumnNameBeneficiary);
            ColumnNames.Add(ColumnNameOwner);
        }
        private void AddIllustrationColumnsContextMenu()
        {
            IllustrationColumnNames = new List<string>();
            IllustrationColumnNames.Add(ColumnNameYear);
            IllustrationColumnNames.Add(ColumnNameAD);
            IllustrationColumnNames.Add(ColumnNameADA);
            IllustrationColumnNames.Add(ColumnNameADR);
            IllustrationColumnNames.Add(ColumnNameCV);
            IllustrationColumnNames.Add(ColumnNameCVA);
            IllustrationColumnNames.Add(ColumnNameCVR);
            IllustrationColumnNames.Add(ColumnNameDB);
            IllustrationColumnNames.Add(ColumnNameDBA);
            IllustrationColumnNames.Add(ColumnNameDBR);
            IllustrationColumnNames.Add(ColumnNameACB);
            IllustrationColumnNames.Add(ColumnNameACBA);
            IllustrationColumnNames.Add(ColumnNameACBR);
            IllustrationColumnNames.Add(ColumnNameNCPI);
            IllustrationColumnNames.Add(ColumnNameNCPIA);
            IllustrationColumnNames.Add(ColumnNameNCPIR);
        }
        public void GetComboData()
        {
            var combo = _unitOfWork.Combo.All();
            Combo = combo.Select(r => _mapper.Map<ViewComboDto>(r)).ToList();
            PersonStatusCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNamePStatus).ToList();
            SVCTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameSVCType).ToList();
            ClientTypeCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameClientType).OrderBy(c => c.Description).ToList();
            ClientTypeCollection.Insert(0, new ViewComboDto() { });
            CompanyCollection = Combo.Where(x => x.FieldName.Trim() == comboFieldNameCompany).OrderBy(c => c.Description).ToList();
            CompanyCollection.Insert(0, new ViewComboDto() { Description = string.Empty });
        }
        public void GetAutoSuggestionLists()
        {
            var policies = _unitOfWork.Policies.GetAllPolicyNumber();
            var temppolicies = policies.Select(r => _mapper.Map<ViewPolicyListDto>(r)).ToList();
            Policies = temppolicies.Select(r => r.PolicyNumber).ToList();
        }
        private void SearchClient()
        {           
            if (IsValidSearchCriteria())
            {
                SearchQuery searchQuery = BuildSearchQuery();
                var dataSearchBy = _unitOfWork.People.Find(searchQuery);
                var dataCollection = new ObservableCollection<ViewClientSearchDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewClientSearchDto>(r)).ToList());

                ClientCollection = new ObservableCollection<ViewClientSearchDto>(dataCollection.Select(x =>
                {
                    x.ClientType = string.IsNullOrEmpty(x.ClientType.Trim()) ? "" : ClientTypeCollection.Where(c => c.FieldCode == x.ClientType.Trim()).FirstOrDefault()?.Description;
                    x.Status = string.IsNullOrEmpty(x.Status.Trim()) ? "" : PersonStatusCollection.Where(c => c.FieldCode == x.Status.Trim()).FirstOrDefault()?.Description;
                    x.SVCType = string.IsNullOrEmpty(x.SVCType.Trim()) ? "" : SVCTypeCollection.Where(c => c.FieldCode == x.SVCType.Trim()).FirstOrDefault()?.Description;
                    return x;
                }));
                if (SelectedViewModel is PolicyViewModel)
                {
                    var policyViewModel = (PolicyViewModel)SelectedViewModel;
                    policyViewModel.ClientCollection = ClientCollection;
                    if (ClientCollection.Count > 0)
                    {
                        policyViewModel.SelectedClient = ClientCollection[0];
                    }
                }
                else if (SelectedViewModel is FileManagerViewModel)
                {
                    var fileManagerViewModel = (FileManagerViewModel)SelectedViewModel;
                    fileManagerViewModel.ClientCollection = ClientCollection;
                    if (ClientCollection.Count > 0)
                    {
                        fileManagerViewModel.SelectedClient = ClientCollection[0];
                    }
                }
                else if (SelectedViewModel is PeopleViewModel)
                {
                    var peopleViewModel = (PeopleViewModel)SelectedViewModel;
                    peopleViewModel.ClientCollection = ClientCollection;
                    if (ClientCollection.Count > 0)
                    {
                        peopleViewModel.SelectedClient = ClientCollection[0];
                    }
                }
            }
        }
        private bool IsValidSearchCriteria()
        {
            bool isValid = true;
            if ((CompanyName == null || (CompanyName != null && CompanyName.Id == 0))
                && string.IsNullOrEmpty(PolicyNumber)
                && string.IsNullOrEmpty(FirstName)
                && string.IsNullOrEmpty(CommanName)
                && string.IsNullOrEmpty(LastName)
                && (EntityType == null || (EntityType != null && EntityType.Id == 0))
                && (FromPolicyDate == null && ToPolicyDate == null))
            {
                isValid = false;
                _notifier.ShowError("Enter valid information to search client");
            }

            if (isValid)
            {
                if (!string.IsNullOrEmpty(PolicyNumber))
                {
                    isValid = Policies.Any(x => x.ToLower().Equals(PolicyNumber.ToLower().Trim()));
                    if (!isValid)
                        _notifier.ShowError("Select valid Policy number");
                }
                if(FromPolicyDate != null && !DateTime.TryParse(FromPolicyDate.ToString(), out _))
                {
                    isValid = false;
                    _notifier.ShowError("Invalid (from)policy date");
                }
                if (ToPolicyDate != null &&  !DateTime.TryParse(ToPolicyDate.ToString(), out _))
                {
                    isValid = false;
                    _notifier.ShowError("Invalid (to)policy date");
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
                BuildFilterByContains("CommonName", CommanName, searchBy);
            }

            if (!string.IsNullOrEmpty(PolicyNumber))
            {
                BuildFilterByContains("PolicyNumber", PolicyNumber.Trim(), searchBy);
            }
            if (CompanyName != null && CompanyName.Id > 0)
            {
                BuildFilterByEquals("CompanyName", CompanyName.FieldCode.Trim(), searchBy);
            }
            if (EntityType != null && EntityType.Id > 0)
            {
                BuildFilterByEquals("EntityType", EntityType.FieldCode.Trim(), searchBy);
            }
            if (FromPolicyDate != null && ToPolicyDate != null)
            {
                BuildFilterByRange("PolicyDate", FromPolicyDate.Value.ToShortDateString(), ToPolicyDate.Value.ToShortDateString(), searchBy);
            }
            if (FromPolicyDate != null && ToPolicyDate == null)
            {
                BuildFilterByRange("PolicyDate", FromPolicyDate.Value.ToShortDateString(), DateTime.Now.ToShortDateString(), searchBy);
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
        public void SaveSearchOptions()
        {
            var originalSearchOptions = _unitOfWork.Options.All().Where(o => o.User == Environment.UserName && o.Key == searchOptionsKey).FirstOrDefault();
            if(originalSearchOptions == null)
            {
                originalSearchOptions = new Options();
                originalSearchOptions.Key = searchOptionsKey;
                originalSearchOptions.Value = JsonConvert.SerializeObject(SearchOptions);
                originalSearchOptions.User = Environment.UserName;
                _unitOfWork.Options.Add(originalSearchOptions);
            }
            else
            {
                originalSearchOptions.Value = JsonConvert.SerializeObject(SearchOptions);
                _unitOfWork.Options.Save(originalSearchOptions);
            }
            _unitOfWork.Commit();
            if(_memoryCache != null)
                _memoryCache.Set(optionsCacheKey, originalSearchOptions);
        }             
        public void CheckCommissionAccess()
        {
            if(_memoryCache != null)
            {
                if(!_memoryCache.TryGetValue(commissionAccessCacheKey, out bool hasCommissionAccess))
                {
                    HasCommissionAccess = _unitOfWork.HasCommissionAccess();
                }
                else
                {
                    HasCommissionAccess = hasCommissionAccess;
                }
            }
        }
        public void GetUserOptions()
        {
            if(_memoryCache != null)
            {
                List<Options> options = default;
                if (!_memoryCache.TryGetValue(optionsCacheKey, out options))
                {
                    options = _unitOfWork.Options.All().Where(o => o.User == Environment.UserName).ToList();
                    _memoryCache.Set(optionsCacheKey, options);
                }
                var searchOptionsValue = options.Where(o => o.Key == searchOptionsKey).FirstOrDefault()?.Value;
                SearchOptions = searchOptionsValue != null ? JsonConvert.DeserializeObject<ObservableCollection<ViewSearchOptionsDto>>(searchOptionsValue) : default;
                if(SearchOptions == null)
                {
                    SearchOptions = new ObservableCollection<ViewSearchOptionsDto>();
                    GetDefaultSearchOptions();
                }
                var policyColumnsValue = options.Where(x => x.Key == PolicyColumnsKey).FirstOrDefault()?.Value;
                PolicyColumns = policyColumnsValue != null ? JsonConvert.DeserializeObject<ObservableCollection<ViewSearchOptionsDto>>(policyColumnsValue) : default;
                if (PolicyColumns == null)
                {
                    PolicyColumns = new ObservableCollection<ViewSearchOptionsDto>();
                    GetDefaultPolicyColumns();
                }

                var illustrationColumnsValue = options.Where(x => x.Key == IllustrationColumnsKey).FirstOrDefault()?.Value;
                IllustrationColumns = illustrationColumnsValue != null ? JsonConvert.DeserializeObject<ObservableCollection<ViewSearchOptionsDto>>(illustrationColumnsValue) : default;
                if (IllustrationColumns == null)
                {
                    IllustrationColumns = new ObservableCollection<ViewSearchOptionsDto>();
                    GetDefaultIllustrationColumns();
                }
            }
        }       
        public void GetDefaultSearchOptions()
        {
            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Common Name",
                ColumnOrder = 0,
                ColumnType = "TextBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Last Name",
                ColumnOrder = 1,
                ColumnType = "TextBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "First Name",
                ColumnOrder = 2,
                ColumnType = "TextBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Entity Type",
                ColumnOrder = 3,
                ColumnType = "ComboBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Policy Number",
                ColumnOrder = 4,
                ColumnType = "ComboBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Company Name",
                ColumnOrder = 5,
                ColumnType = "ComboBox"
            });

            SearchOptions.Add(new ViewSearchOptionsDto()
            {
                ColumnName = "Policy Date",
                ColumnOrder = 6,
                ColumnType = "DatePicker"
            });
        }
        public void SaveOptionKeyPolicyColumns()
        {
            var originalPolicyColumn = _unitOfWork.Options.All().Where(o => o.User == Environment.UserName && o.Key == PolicyColumnsKey).FirstOrDefault();
            if (originalPolicyColumn == null)
            {
                originalPolicyColumn = new Options();
                originalPolicyColumn.Key = PolicyColumnsKey;
                originalPolicyColumn.Value = JsonConvert.SerializeObject(PolicyColumns);
                originalPolicyColumn.User = Environment.UserName;
                _unitOfWork.Options.Add(originalPolicyColumn);
            }
            else
            {
                originalPolicyColumn.Value = JsonConvert.SerializeObject(PolicyColumns);
                _unitOfWork.Options.Save(originalPolicyColumn);
            }
            _unitOfWork.Commit();
            if (_memoryCache != null)
                _memoryCache.Set(optionsCacheKey, originalPolicyColumn);
        }
        public void SaveOptionKeyIllustrationColumns()
        {
            var originalIllustrationColumn = _unitOfWork.Options.All().Where(o => o.User == Environment.UserName && o.Key == IllustrationColumnsKey).FirstOrDefault();
            if (originalIllustrationColumn == null)
            {
                originalIllustrationColumn = new Options();
                originalIllustrationColumn.Key = IllustrationColumnsKey;
                originalIllustrationColumn.Value = JsonConvert.SerializeObject(IllustrationColumns);
                originalIllustrationColumn.User = Environment.UserName;
                _unitOfWork.Options.Add(originalIllustrationColumn);
            }
            else
            {
                originalIllustrationColumn.Value = JsonConvert.SerializeObject(IllustrationColumns);
                _unitOfWork.Options.Save(originalIllustrationColumn);
            }
            _unitOfWork.Commit();
            if (_memoryCache != null)
                _memoryCache.Set(optionsCacheKey, originalIllustrationColumn);
        }
        private void GetDefaultPolicyColumns()
        {
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNamePolicyNumber,
                ColumnOrder = 1
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameCompany,
                ColumnOrder = 2
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameFaceAmount,
                ColumnOrder = 3
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNamePayment,
                ColumnOrder = 4
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameStatus,
                ColumnOrder = 5
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameFrequency,
                ColumnOrder = 6
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameType,
                ColumnOrder = 7
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNamePlanCode,
                ColumnOrder = 8
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameRating,
                ColumnOrder = 9
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameClass,
                ColumnOrder = 10
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameCurrency,
                ColumnOrder = 11
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNamePolicyDate,
                ColumnOrder = 12
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNamePlacedOn,
                ColumnOrder = 13
            });
            PolicyColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameReprojectedOn,
                ColumnOrder = 14
            });
        }
        private void GetDefaultIllustrationColumns()
        {
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameYear,
                ColumnOrder = 1
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameAD,
                ColumnOrder = 2
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameADA,
                ColumnOrder = 3
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameADR,
                ColumnOrder = 4
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameCV,
                ColumnOrder = 5
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameCVA,
                ColumnOrder = 6
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameCVR,
                ColumnOrder = 7
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameDB,
                ColumnOrder = 8
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameDBA,
                ColumnOrder = 9
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameDBR,
                ColumnOrder = 10
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameACB,
                ColumnOrder = 11
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameACBA,
                ColumnOrder = 12
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameACBR,
                ColumnOrder = 13
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameNCPI,
                ColumnOrder = 14
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameNCPIA,
                ColumnOrder = 15
            });
            IllustrationColumns.Add(new ViewSearchOptionsDto()
            {
                ColumnName = ColumnNameNCPIR,
                ColumnOrder = 16
            });
        }
        #endregion Methods
    }
}
