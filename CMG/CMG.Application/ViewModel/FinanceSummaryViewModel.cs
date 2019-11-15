using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Windows.Input;
using static CMG.Common.Enums;

namespace CMG.Application.ViewModel
{
    public class FinanceSummaryViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork; 
        private readonly IMapper _mapper;
        private const int startYear = 1925;
        private int newId;
        private int maxWithdrawalId;
        private const string AgentExpenses = "Agent Expenses";
        private const string DueToPartners = "Due To Partners";
        private const string BankPositions = "Bank Positions";
        private const string PersonalCommissions = "Personal Commissions";
        private const string BankPositionCode = "B";

        private const string WithdrawalIdCoulmnName = "WithdrawalId";
        private const string DescriptionCoulmnName = "Description";
        private const string TypeCoulmnName = "Type";
        private const string CmgCoulmnName = "CMG";
        private const string ScCoulmnName = "SC";
        private const string TdCoulmnName = "TD";
        #endregion Member variables

        #region Constructor
        public FinanceSummaryViewModel(IUnitOfWork unitOfWork, IMapper mapper)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            maxWithdrawalId = _unitOfWork.Withdrawals.All().OrderByDescending(x => x.Keywith).First().Keywith;
            LoadData();            
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
                LoadData();
            }
        }

        private string _selectedMonth = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("MMM", CultureInfo.InvariantCulture);
        public string SelectedMonth
        {
            get { return _selectedMonth; }
            set
            {
                _selectedMonth = value;
                OnPropertyChanged("SelectedMonth");
                LoadData();
            }
        }

        private ViewWithdrawalDto selectedRow;
        public ViewWithdrawalDto SelectedRow
        {
            get { return selectedRow; }
            set
            {
                selectedRow = value;
                OnPropertyChanged("IsNoRecordFound");
            }
        }

        private ObservableCollection<ViewWithdrawalDto> _dueToPartnersCollection;
        public ObservableCollection<ViewWithdrawalDto> DueToPartnersCollection
        {
            get { return _dueToPartnersCollection; }
            set
            {
                _dueToPartnersCollection = value;
                OnPropertyChanged("DueToPartnersCollection");
                OnPropertyChanged("IsNoRecordFound");
            }
        }

        private ObservableCollection<ViewAgentDto> _agentList;
        public ObservableCollection<ViewAgentDto> AgentList
        {
            get { return _agentList; }
            set
            {
                _agentList = value;
                OnPropertyChanged("AgentList");
            }
        }
        private ObservableCollection<ViewWithdrawalDto> _agentExpensesCollection;
        public ObservableCollection<ViewWithdrawalDto> AgentExpensesCollection
        {
            get { return _agentExpensesCollection; }
            set
            {
                _agentExpensesCollection = value;
                OnPropertyChanged("AgentExpensesCollection");
            }
        }

        private ObservableCollection<ViewWithdrawalDto> _bankPositionsCollection;
        public ObservableCollection<ViewWithdrawalDto> BankPositionsCollection
        {
            get { return _bankPositionsCollection; }
            set
            {
                _bankPositionsCollection = value;
                OnPropertyChanged("BankPositionsCollection");
            }
        }

        private ObservableCollection<ViewWithdrawalDto> _personalCommissionsCollection;
        public ObservableCollection<ViewWithdrawalDto> PersonalCommissionsCollection
        {
            get { return _personalCommissionsCollection; }
            set
            {
                _personalCommissionsCollection = value;
                OnPropertyChanged("PersonalCommissionsCollection");
            }
        }

        private DataTable _bankPositionsTable;
        public DataTable BankPositionsTable
        {
            get { return _bankPositionsTable; }
            set
            {
                _bankPositionsTable = value;
                OnPropertyChanged("BankPositionsTable");
            }
        }
        public ICommand RemoveAgentCommand
        {
            get { return CreateCommand(RemoveAgent); }
        }

        private bool isAddAgentVisible;
        public bool IsAddAgentVisible
        {
            get { return isAddAgentVisible; }
            set
            {
                isAddAgentVisible = value;
                OnPropertyChanged("IsAddAgentVisible");
            }
        }
        public ICommand AddAgentCommand
        {
            get { return CreateCommand(AddWithdrawalAgent); }
        }
        public ICommand AddCommand
        {
            get
            { return CreateCommand(AddWithdrawal); }
        }
        public ICommand SaveCommand
        {
            get { return CreateCommand(SaveWithdrawals); }
        }
        public string LabelAgentExpenses
        {
            get
            { return AgentExpenses; }
        }
        public string LabelDueToPartners
        {
            get { return DueToPartners;  }
        }
        public string LabelBankPositions
        {
            get { return BankPositions; }
        }
        public string LabelPersonalCommissions
        {
            get { return PersonalCommissions; }
        }
        #endregion Properties

        #region Methods
        public void LoadData()
        {
            GetAgents();
            GetAgentExpenses();
            GetDueToPartners();
            GetBankPositions();
            //GetPersonalCommissions();
        }
        public void GetDueToPartners()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            DueToPartnersCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());
        }
        public void GetAgentExpenses()
        {
            SearchQuery searchQuery = BuildSearchQuery("W");
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            AgentExpensesCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());
        }
        public void GetPersonalCommissions()
        {
            SearchQuery searchQuery = BuildSearchQuery("P");
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            PersonalCommissionsCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());
        }
        public void GetBankPositions()
        {
            SearchQuery searchQuery = BuildSearchQuery("B");
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            BankPositionsCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList());

            BankPositionsTable = new DataTable();
            BankPositionsTable.TableName = "BankPositions";

            BankPositionsTable.Columns.Add(WithdrawalIdCoulmnName, typeof(int));
            BankPositionsTable.Columns.Add(DescriptionCoulmnName, typeof(string));
            BankPositionsTable.Columns.Add(TypeCoulmnName, typeof(string));
            BankPositionsTable.Columns.Add(CmgCoulmnName, typeof(decimal));
            BankPositionsTable.Columns.Add(ScCoulmnName, typeof(decimal));
            BankPositionsTable.Columns.Add(TdCoulmnName, typeof(decimal));

            DataRow row;
            for (int i = 0; i < BankPositionsCollection.Count; i++)
            {
                row = BankPositionsTable.NewRow();
                row[WithdrawalIdCoulmnName] = BankPositionsCollection[i].WithdrawalId;
                row[DescriptionCoulmnName] = BankPositionsCollection[i].Desc.Trim();
                row[TypeCoulmnName] = BankPositionsCollection[i].Ctype.Trim();
                row[CmgCoulmnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault().Amount : 0;
                row[ScCoulmnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault().Amount : 0;
                row[TdCoulmnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault().Amount : 0;
                BankPositionsTable.Rows.Add(row);
            }
        }
        public void AddWithdrawal(object currentGrid)
        {
            var id = --newId;
            string month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month.ToString("00");
            List<ViewAgentWithdrawalDto> listViewAgentWithdrawal = new List<ViewAgentWithdrawalDto>();
            ViewAgentWithdrawalDto viewAgentWithdrawal = new ViewAgentWithdrawalDto() { WithdrawalId = id, IsVisible = false };
            listViewAgentWithdrawal.Add(viewAgentWithdrawal);
            if (Convert.ToString(currentGrid) == AgentExpenses)
            {
                AgentExpensesCollection.Add(new ViewWithdrawalDto() { WithdrawalId = id, Dtype = "W", Yrmo = $"{SelectedYear}{month}", Ctype = "", AgentWithdrawals = listViewAgentWithdrawal });
            }
            else if (Convert.ToString(currentGrid) == DueToPartners)
            {
                DueToPartnersCollection.Add(new ViewWithdrawalDto() { WithdrawalId = id, Dtype = "L", Yrmo = $"{SelectedYear}{month}", Ctype = "", AgentWithdrawals = listViewAgentWithdrawal });
            }
            else if(Convert.ToString(currentGrid) == BankPositions)
            {
                DataRow row = BankPositionsTable.NewRow();
                row[WithdrawalIdCoulmnName] = id;
                row[CmgCoulmnName] = 0;
                row[ScCoulmnName] = 0;
                row[TdCoulmnName] = 0;
                BankPositionsTable.Rows.Add(row);
            }
        }
        public void RemoveAgent(object selectedAgentWithdrawal)
        {
            object[] selectedObject = selectedAgentWithdrawal as object[];
            var _selectedAgentWithdrawal = (ViewAgentWithdrawalDto)selectedObject[0];
            var _currentGrid = selectedObject[1].ToString();
            _selectedAgentWithdrawal.IsVisible = false;
            if(_currentGrid == AgentExpenses)
            {
                RemoveAgentFromCollection(AgentExpensesCollection, _selectedAgentWithdrawal);
            } 
            else if(_currentGrid == DueToPartners)
            {
                RemoveAgentFromCollection(DueToPartnersCollection, _selectedAgentWithdrawal);
            }
        }
        public void SaveWithdrawals()
        {
            if(AgentExpensesCollection != null && AgentExpensesCollection.Count > 0)
            {
                AddOrUpdateWithdrawalCollection(AgentExpensesCollection);
            }
            if(DueToPartnersCollection != null && DueToPartnersCollection.Count > 0)
            {
                AddOrUpdateWithdrawalCollection(DueToPartnersCollection);
            }
            if(BankPositionsTable.Rows.Count > 0)
            {
                AddOrUpdateBankPositionCollection();
            }
            _unitOfWork.Commit();
              LoadData();
        }
        public void AddWithdrawalAgent(object dataInput)
        {
            if (dataInput != null)
            {
                IList objList = (IList)dataInput;
                if (objList != null
                    && objList.Count == 3)
                {
                    ViewAgentDto agent = (ViewAgentDto)objList[0];
                    switch (objList[1])
                    {
                        case AgentExpenses:
                            AddAgentFromCollection(AgentExpensesCollection, (List<ViewAgentWithdrawalDto>)objList[2], agent);
                            break;
                        case DueToPartners:
                            AddAgentFromCollection(DueToPartnersCollection, (List<ViewAgentWithdrawalDto>)objList[2], agent);
                            break;
                    }
                }
            }
        }
        private SearchQuery BuildSearchQuery(string dType = "L")
        {
            int month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month;
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> filterBy = new List<FilterBy>();
            filterBy.Add(FilterByEqual("yrmo", SelectedYear.ToString() + month.ToString("D2")));
            filterBy.Add(FilterByEqual("dtype", dType));
            searchQuery.FilterBy = filterBy;
            return searchQuery;
        }
        private FilterBy FilterByEqual(string propertyName, string value)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.Equal = value;
            return filterBy;
        }
        private void GetAgents()
        {
            var agents = _unitOfWork.Agents.All().ToList().Where(x => x.IsExternal == false);
            AgentList = new ObservableCollection<ViewAgentDto>(agents.Select(r => _mapper.Map<ViewAgentDto>(r)).ToList());
        }
        private void RemoveAgentFromCollection(ObservableCollection<ViewWithdrawalDto> collection, ViewAgentWithdrawalDto selectedAgent)
        {
            var currentAgentWithdrawal = collection.Where(expense => expense.WithdrawalId == selectedAgent.WithdrawalId).SingleOrDefault();
            var index = collection.IndexOf(currentAgentWithdrawal);
            collection.Remove(currentAgentWithdrawal);
            collection.Insert(index, currentAgentWithdrawal);
        }
        private void AddOrUpdateWithdrawalCollection(ObservableCollection<ViewWithdrawalDto> collection)
        {
            if (collection != null && collection.Count > 0)
            {
                foreach (ViewWithdrawalDto withdrawal in collection)
                {
                    withdrawal.AgentWithdrawals.Remove(withdrawal.AgentWithdrawals.Where(x => x.AgentId == null).FirstOrDefault());

                    if (withdrawal.WithdrawalId > 0)
                    {
                        var entity = _mapper.Map<Withd>(withdrawal);
                        foreach (AgentWithdrawal agentWithdrawal in entity.AgentWithdrawal)
                        {
                            var obj = withdrawal.AgentWithdrawals.Where(x => x.Id == agentWithdrawal.Id).FirstOrDefault();
                            if (obj.IsVisible == false)
                            {
                                agentWithdrawal.IsDeleted = true;
                            }
                            agentWithdrawal.Agent = null;
                            if (agentWithdrawal.Id > 0)
                            {
                                _unitOfWork.AgentWithdrawals.Save(agentWithdrawal);
                            }
                            else
                            {
                                if(!agentWithdrawal.IsDeleted)
                                {
                                    _unitOfWork.AgentWithdrawals.Add(agentWithdrawal);
                                }
                            }
                        }
                        _unitOfWork.Withdrawals.Save(entity);
                    }
                    else
                    {
                        withdrawal.AgentWithdrawals = withdrawal.AgentWithdrawals.Where(x => x.IsVisible == true).Select(agentWithd => { agentWithd.Agent = null; return agentWithd; }).ToList();
                        withdrawal.WithdrawalId = ++maxWithdrawalId;
                        var entityWithdrawal = _mapper.Map<Withd>(withdrawal);
                        _unitOfWork.Withdrawals.Add(entityWithdrawal);
                    }
                }
            }
        }
        private void AddOrUpdateBankPositionCollection()
        {
            if(BankPositionsTable.Rows.Count > 0)
            {
                foreach(DataRow row in BankPositionsTable.Rows) // Rishita
                {
                    int month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month;
                    ViewWithdrawalDto withdrawal = new ViewWithdrawalDto();
                    List<ViewAgentWithdrawalDto> agentWithdrawals = new List<ViewAgentWithdrawalDto>();
                    ViewAgentWithdrawalDto agentWithdrawal = new ViewAgentWithdrawalDto();
                    int withdrawalId = (int)row[WithdrawalIdCoulmnName];
                    withdrawal.WithdrawalId = withdrawalId;
                    withdrawal.Yrmo = SelectedYear.ToString() + month.ToString("D2");
                    withdrawal.Desc = row[DescriptionCoulmnName].ToString().Trim();
                    withdrawal.Dtype = BankPositionCode;
                    withdrawal.Ctype = row[TypeCoulmnName].ToString().Trim();
                    if (withdrawalId > 0)
                    {
                        withdrawal = BankPositionsCollection.Where(x => x.WithdrawalId == withdrawalId).FirstOrDefault();
                        agentWithdrawals = withdrawal.AgentWithdrawals.ToList();
                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[CmgCoulmnName]);
                        }
                        else if(Convert.ToDouble(row[CmgCoulmnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[CmgCoulmnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[ScCoulmnName]);
                        }
                        else if(Convert.ToDouble(row[ScCoulmnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[ScCoulmnName])));
                        }
                        
                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[TdCoulmnName]);
                        }
                        else if(Convert.ToDouble(row[TdCoulmnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[TdCoulmnName])));
                        }
                    }
                    else if (withdrawalId < 0)
                    {
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[CmgCoulmnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[ScCoulmnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[TdCoulmnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }

                        withdrawal.AgentWithdrawals = agentWithdrawals;
                        BankPositionsCollection.Add(withdrawal);
                    }
                }
                AddOrUpdateWithdrawalCollection(BankPositionsCollection);
            }
        }

        private ViewAgentWithdrawalDto AddViewAgentWithdrawalDto(int agentId, int withdrawalId, double amount)
        {
            ViewAgentWithdrawalDto agentWithdrawal = null;
            if (amount > 0)
            {
                agentWithdrawal = new ViewAgentWithdrawalDto();
                agentWithdrawal.Agent = AgentList.Where(x => x.Id == agentId).FirstOrDefault();
                agentWithdrawal.WithdrawalId = withdrawalId;
                agentWithdrawal.AgentId = agentId;
                agentWithdrawal.Amount = amount;
            }
            return agentWithdrawal;
        }
        private void AddAgentFromCollection(ObservableCollection<ViewWithdrawalDto> collection, List<ViewAgentWithdrawalDto> agentWithdrawals, ViewAgentDto agent)
        {
            if (collection.Count > 0)
            {
                ViewWithdrawalDto selectedWithdrawal = new ViewWithdrawalDto();
                selectedWithdrawal = collection.Where(x => x.WithdrawalId == agentWithdrawals[0].WithdrawalId).FirstOrDefault();

                ViewAgentWithdrawalDto agentWithdrawalExists = selectedWithdrawal.AgentWithdrawals.Where(a => a.AgentId == agent.Id).FirstOrDefault();
                ViewAgentWithdrawalDto viewAgentWithdrawalDto = new ViewAgentWithdrawalDto();
                viewAgentWithdrawalDto.AgentId = agent.Id;
                viewAgentWithdrawalDto.Id = 0;
                viewAgentWithdrawalDto.Amount = 0;
                viewAgentWithdrawalDto.WithdrawalId = selectedWithdrawal.WithdrawalId;
                viewAgentWithdrawalDto.Agent = agent;

                if (agentWithdrawalExists != null
                    && agentWithdrawalExists.IsVisible)
                {
                    return;
                }

                selectedWithdrawal.AgentWithdrawals.Remove(agentWithdrawalExists);
                selectedWithdrawal.AgentWithdrawals.Add(viewAgentWithdrawalDto);
                int index = collection.IndexOf(selectedWithdrawal);
                collection.Remove(selectedWithdrawal);
                collection.Insert(index, selectedWithdrawal);                
            }
        }
        #endregion Methods
    }
}
