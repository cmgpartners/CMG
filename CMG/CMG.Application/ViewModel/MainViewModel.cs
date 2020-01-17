﻿using System;
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
        private const string searchoptionsCacheKey = "options";
        
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
        private string _entityType;
        public string EntityType
        {
            get { return _entityType; }
            set
            {
                _entityType = value;
                OnPropertyChanged("EntityType");
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
        private List<string> _entityTypes;
        public List<string> EntityTypes
        {
            get { return _entityTypes; }
            set
            {
                _entityTypes = value;
                OnPropertyChanged("EntityTypes");
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
        public ICommand SearchClientCommand
        {
            get { return CreateCommand(Search); }
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
        private void Search()
        {
            PolicyViewModel policyViewModel = new PolicyViewModel(_unitOfWork, _mapper, SelectedClient, _memoryCache, null, _notifier);
            PersonStatusCollection = policyViewModel.PersonStatusCollection;
            SVCTypeCollection = policyViewModel.SVCTypeCollection;
            CompanyCollection = policyViewModel.CompanyCollection;
            Policies = policyViewModel.Policies;
            EntityTypes = policyViewModel.EntityTypes;
            ClientTypeCollection = policyViewModel.ClientTypeCollection;
            CompanyNames = policyViewModel.CompanyNames;
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
            }
        }
        private bool IsValidSearchCriteria()
        {
            bool isValid = true;
            if (string.IsNullOrEmpty(CompanyName)
                && string.IsNullOrEmpty(PolicyNumber)
                && string.IsNullOrEmpty(FirstName)
                && string.IsNullOrEmpty(CommanName)
                && string.IsNullOrEmpty(LastName)
                && string.IsNullOrEmpty(EntityType))
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

                if (!string.IsNullOrEmpty(EntityType))
                {
                    isValid = EntityTypes.Any(x => x.ToLower().Equals(EntityType.ToLower().Trim()));
                    if (!isValid)
                        _notifier.ShowError("Select valid entity type");
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

            if (!string.IsNullOrEmpty(PolicyNumber))
            {
                BuildFilterByContains("PolicyNumber", PolicyNumber.Trim(), searchBy);
            }
            if (!string.IsNullOrEmpty(CompanyName))
            {
                var companyCode = CompanyCollection.Where(c => c.Description.ToLower() == CompanyName.Trim().ToLower()).FirstOrDefault()?.FieldCode;
                if (!string.IsNullOrEmpty(companyCode))
                {
                    BuildFilterByEquals("CompanyName", companyCode.Trim(), searchBy);
                }
            }
            if (!string.IsNullOrEmpty(EntityType))
            {
                var entityTypeCode = ClientTypeCollection.Where(c => c.Description.ToLower() == EntityType.Trim().ToLower()).FirstOrDefault()?.FieldCode;
                if (!string.IsNullOrEmpty(entityTypeCode))
                {
                    BuildFilterByEquals("EntityType", entityTypeCode.Trim(), searchBy);
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
                _memoryCache.Set(searchoptionsCacheKey, originalSearchOptions);
        }
        public void GetUserOptions()
        {
            
            if(_memoryCache != null)
            {
                List<Options> options = default;
                if (!_memoryCache.TryGetValue(searchoptionsCacheKey, out options))
                {
                    options = _unitOfWork.Options.All().Where(o => o.User == Environment.UserName).ToList();
                    _memoryCache.Set(searchoptionsCacheKey, options);
                }
                var searchOptionsValue = options.Where(o => o.Key == searchOptionsKey).FirstOrDefault()?.Value;
                SearchOptions = searchOptionsValue != null ? JsonConvert.DeserializeObject<ObservableCollection<ViewSearchOptionsDto>>(searchOptionsValue) : default;
                if(SearchOptions == null)
                {
                    SearchOptions = new ObservableCollection<ViewSearchOptionsDto>();
                    GetDefaultSearchOptions();
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
        #endregion Methods
    }
}
