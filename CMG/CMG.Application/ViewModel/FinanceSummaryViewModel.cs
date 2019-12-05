using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using CMG.Service;
using CMG.Service.Interface;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Windows.Input;
using ToastNotifications;
using ToastNotifications.Messages;
using static CMG.Common.Enums;

namespace CMG.Application.ViewModel
{
    public class FinanceSummaryViewModel : MainViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork; 
        private readonly IMapper _mapper;
        public readonly IDialogService _dialogService;
        private readonly Notifier _notifier;
        private const int startYear = 1925;
        private int newId;
        private int maxWithdrawalId;
        private bool isValidRecord;
        private const string AgentExpenses = "Agent Expenses";
        private const string DueToPartners = "Due To Partners";
        private const string BankPositions = "Bank Positions";
        private const string PersonalCommissions = "Personal Commissions";
        private const string BankPositionCode = "B";
        private const string AgentExpenseCode = "W";
        private const string DueToPartnerCode = "L";
        private const string PersonalCommissionEnteredCode = "P";
        private const string PersonalCommissionNotEnteredCode = "N";

        private const string WithdrawalIdColumnName = "WithdrawalId";
        private const string DescriptionColumnName = "Description";
        private const string TypeColumnName = "Type";
        private const string CmgColumnName = "CMG";
        private const string ScColumnName = "SC";
        private const string TdColumnName = "TD";
        private const string MartyColumnName = "Marty";
        private const string PeterColumnName = "Peter";
        private const string FrankColumnName = "Frank";
        private const string BobColumnName = "Bob";
        private const string OtherColumnName = "Other";
        private const string IsPcEnteredColumnName = "IsPcEntered";
        #endregion Member variables

        #region Constructor
        public FinanceSummaryViewModel(IUnitOfWork unitOfWork, IMapper mapper, IDialogService dialogService = null, Notifier notifier = null)
            : base(unitOfWork, mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _notifier = notifier;
            _dialogService = dialogService;
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

        private DataTable _agentExpensesTable;
        public DataTable AgentExpensesTable
        {
            get { return _agentExpensesTable; }
            set
            {
                _agentExpensesTable = value;
                OnPropertyChanged("AgentExpensesTable");
            }
        }

        private DataTable _dueToPartnersTable;
        public DataTable DueToPartnersTable
        {
            get { return _dueToPartnersTable; }
            set
            {
                _dueToPartnersTable = value;
                OnPropertyChanged("DueToPartnersTable");
            }
        }

        private DataTable _personalcommissionsTable;
        public DataTable PersonalcommissionsTable
        {
            get { return _personalcommissionsTable; }
            set
            {
                _personalcommissionsTable = value;
                OnPropertyChanged("PersonalcommissionsTable");
            }
        }
        public ICommand RemoveAgentCommand
        {
            get { return CreateCommand(RemoveAgent); }
        }

        public ICommand RemoveWithdrawalCommand
        {
            get { return CreateCommand(RemoveWithdrawal); }
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
            GetPersonalCommissions();
            AgentExpensesTable = CollectionToDataTable(AgentExpensesCollection, AgentExpenses);
            DueToPartnersTable = CollectionToDataTable(DueToPartnersCollection, DueToPartners);
        }
        public void GetDueToPartners()
        {
            SearchQuery searchQuery = BuildSearchQuery();
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            DueToPartnersCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList().Where(x => x.IsDeleted == false));
        }
        public void GetAgentExpenses()
        {
            SearchQuery searchQuery = BuildSearchQuery(AgentExpenseCode);
            var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
            AgentExpensesCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList().Where(x => x.IsDeleted == false));
        }
        public void GetPersonalCommissions(ObservableCollection<ViewWithdrawalDto> dataInput = null)
        {
            if (dataInput == null)
            {
                SearchQuery searchQuery = BuildSearchQuery(PersonalCommissionEnteredCode + "," + PersonalCommissionNotEnteredCode);
                var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
                PersonalCommissionsCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList().Where(x => x.IsDeleted == false));
            }

            PersonalcommissionsTable = new DataTable();
            PersonalcommissionsTable.TableName = PersonalCommissions;

            PersonalcommissionsTable.Columns.Add(WithdrawalIdColumnName, typeof(int));
            PersonalcommissionsTable.Columns.Add(IsPcEnteredColumnName, typeof(bool));
            PersonalcommissionsTable.Columns.Add(MartyColumnName, typeof(decimal));
            PersonalcommissionsTable.Columns.Add(PeterColumnName, typeof(decimal));
            PersonalcommissionsTable.Columns.Add(FrankColumnName, typeof(decimal));
            PersonalcommissionsTable.Columns.Add(BobColumnName, typeof(decimal));

            DataRow row;
            for (int i = 0; i < PersonalCommissionsCollection.Count; i++)
            {
                row = PersonalcommissionsTable.NewRow();
                row[WithdrawalIdColumnName] = PersonalCommissionsCollection[i].WithdrawalId;
                row[IsPcEnteredColumnName] = PersonalCommissionsCollection[i].Dtype.Trim() == PersonalCommissionEnteredCode ? true : false;
                row[MartyColumnName] = PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null ? PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault().Amount : 0;
                row[PeterColumnName] = PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null ? PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault().Amount : 0;
                row[FrankColumnName] = PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null ? PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault().Amount : 0;
                row[BobColumnName] = PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault() != null ? PersonalCommissionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault().Amount : 0;

                PersonalcommissionsTable.Rows.Add(row);
            }

        }

        private DataTable CollectionToDataTable(ObservableCollection<ViewWithdrawalDto> dataInput, string tableName)
        {
            DataTable table = new DataTable();            
            table.TableName = tableName;
            table.Columns.Add(WithdrawalIdColumnName, typeof(int));
            table.Columns.Add(DescriptionColumnName, typeof(string));
            table.Columns.Add(MartyColumnName, typeof(decimal));
            table.Columns.Add(PeterColumnName, typeof(decimal));
            table.Columns.Add(FrankColumnName, typeof(decimal));
            table.Columns.Add(BobColumnName, typeof(decimal));
            table.Columns.Add(OtherColumnName, typeof(decimal));
            
            DataRow row;
            for (int i = 0; i < dataInput.Count; i++)
            {
                row = table.NewRow();
                row[WithdrawalIdColumnName] = dataInput[i].WithdrawalId;
                row[DescriptionColumnName] = dataInput[i].Desc;
                row[MartyColumnName] = dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault()!= null ? dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault().Amount : 0;
                row[PeterColumnName] = dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault()!= null ? dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault().Amount : 0;
                row[FrankColumnName] = dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault()!= null ? dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault().Amount : 0;
                row[BobColumnName] = dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault()!= null ? dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault().Amount : 0;
                row[OtherColumnName] = dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Others).FirstOrDefault() != null ? dataInput[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Others).FirstOrDefault().Amount : 0;
                
                table.Rows.Add(row);
            }

            return table;
        }

        public void GetBankPositions(ObservableCollection<ViewWithdrawalDto> dataInput = null)
        {
            if (dataInput == null)
            {
                SearchQuery searchQuery = BuildSearchQuery(BankPositionCode);
                var dataSearchBy = _unitOfWork.Withdrawals.Find(searchQuery);
                BankPositionsCollection = new ObservableCollection<ViewWithdrawalDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewWithdrawalDto>(r)).ToList().Where(x => x.IsDeleted == false));
            }

            BankPositionsTable = new DataTable();
            BankPositionsTable.TableName = BankPositions;

            BankPositionsTable.Columns.Add(WithdrawalIdColumnName, typeof(int));
            BankPositionsTable.Columns.Add(DescriptionColumnName, typeof(string));
            BankPositionsTable.Columns.Add(TypeColumnName, typeof(string));
            BankPositionsTable.Columns.Add(CmgColumnName, typeof(decimal));
            BankPositionsTable.Columns.Add(ScColumnName, typeof(decimal));
            BankPositionsTable.Columns.Add(TdColumnName, typeof(decimal));

            DataRow row;
            for (int i = 0; i < BankPositionsCollection.Count; i++)
            {
                row = BankPositionsTable.NewRow();
                row[WithdrawalIdColumnName] = BankPositionsCollection[i].WithdrawalId;
                row[DescriptionColumnName] = BankPositionsCollection[i].Desc.Trim();
                row[TypeColumnName] = BankPositionsCollection[i].Ctype.Trim();
                row[CmgColumnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault().Amount : 0;
                row[ScColumnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault().Amount : 0;
                row[TdColumnName] = BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null ? BankPositionsCollection[i].AgentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault().Amount : 0;
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
                CreateNewRow(AgentExpensesTable, id, AgentExpenses);
            }
            else if (Convert.ToString(currentGrid) == DueToPartners)
            {
                CreateNewRow(DueToPartnersTable, id, DueToPartners);
            }
            else if(Convert.ToString(currentGrid) == BankPositions)
            {
                CreateNewRow(BankPositionsTable, id, BankPositions);
            }
            else if(Convert.ToString(currentGrid) == PersonalCommissions)
            {
                CreateNewRow(PersonalcommissionsTable, id, PersonalCommissions);
            }
        }

        public void CreateNewRow(DataTable table, int newid, string inputCase)
        {
            DataRow row = table.NewRow();
            row[WithdrawalIdColumnName] = newid;
            if (inputCase == BankPositions)
            {
                row[CmgColumnName] = 0;
                row[ScColumnName] = 0;
                row[TdColumnName] = 0;
            }
            else
            {
                row[MartyColumnName] = 0;
                row[PeterColumnName] = 0;
                row[FrankColumnName] = 0;
                row[BobColumnName] = 0;
                if (inputCase != PersonalCommissions)
                {
                    row[OtherColumnName] = 0;
                }
                if (inputCase == PersonalCommissions)
                {
                    row[IsPcEnteredColumnName] = false;
                }
            }
            table.Rows.Add(row);
        }

        public void RemoveWithdrawal(object selectedAgentWithdrawal)
        {
            var result = _dialogService.ShowMessageBox("Are you sure you want to delete the record?");
            if (result == DialogServiceLibrary.MessageBoxResult.Yes)
            {
                if (selectedAgentWithdrawal != null)
                {
                    ViewWithdrawalDto withdrawal = new ViewWithdrawalDto();
                    ObservableCollection<ViewWithdrawalDto> collection = new ObservableCollection<ViewWithdrawalDto>();
                    DataTable table = new DataTable();
                    IList objList = (IList)selectedAgentWithdrawal;
                    string tableName = string.Empty;
                    string withdrawalType = string.Empty;
                    if (objList.Count > 1)
                    {
                        DataRow row = ((DataRowView)objList[0]).Row;
                        switch (objList[1])
                        {
                            case AgentExpenses:
                                withdrawal = AgentExpensesCollection.Where(x => x.WithdrawalId == (int)row[WithdrawalIdColumnName]).FirstOrDefault();
                                collection = AgentExpensesCollection;
                                tableName = AgentExpenses;
                                table = AgentExpensesTable;
                                withdrawalType = AgentExpenseCode;
                                AddOrUpdateWithdrawalTableToCollection(table, collection, withdrawalType, AgentExpenses);
                                break;
                            case DueToPartners:
                                withdrawal = DueToPartnersCollection.Where(x => x.WithdrawalId == (int)row[WithdrawalIdColumnName]).FirstOrDefault();
                                collection = DueToPartnersCollection;
                                tableName = DueToPartners;
                                table = DueToPartnersTable;
                                withdrawalType = DueToPartnerCode;
                                AddOrUpdateWithdrawalTableToCollection(DueToPartnersTable, collection, withdrawalType, DueToPartners);
                                break;
                            case BankPositions:
                                withdrawal = BankPositionsCollection.Where(x => x.WithdrawalId == (int)row[WithdrawalIdColumnName]).FirstOrDefault();
                                collection = BankPositionsCollection;
                                tableName = BankPositions;
                                table = BankPositionsTable;
                                AddOrUpdateBankPositionCollection();
                                break;
                            case PersonalCommissions:
                                withdrawal = PersonalCommissionsCollection.Where(x => x.WithdrawalId == (int)row[WithdrawalIdColumnName]).FirstOrDefault();
                                collection = PersonalCommissionsCollection;
                                tableName = PersonalCommissions;
                                table = PersonalcommissionsTable;
                                AddOrUpdatePersonalCommissionCollection();
                                break;
                        }
                        if ((int)row[WithdrawalIdColumnName] > 0)
                        {
                            withdrawal.IsDeleted = true;
                            withdrawal.AgentWithdrawals.ToList().ForEach(x => x.IsDeleted = true);

                            AddOrUpdateWithdrawalCollection(new ObservableCollection<ViewWithdrawalDto>(collection.Where(x => x.WithdrawalId == withdrawal.WithdrawalId).ToList()));
                            _unitOfWork.Commit();
                        }
                        collection.Remove(collection.Where(x => x.WithdrawalId == (int)row[WithdrawalIdColumnName]).FirstOrDefault());
                        if (objList[1].ToString() == AgentExpenses)
                        {
                            AgentExpensesTable = CollectionToDataTable(collection, tableName);
                        }
                        else if (objList[1].ToString() == DueToPartners)
                        {
                            DueToPartnersTable = CollectionToDataTable(collection, tableName);
                        }
                        else if (objList[1].ToString() == BankPositions)
                        {
                            GetBankPositions(collection);
                        }
                        else if (objList[1].ToString() == PersonalCommissions)
                        {
                            GetPersonalCommissions(collection);
                        }
                    }
                }
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
            isValidRecord = true;
            if (AgentExpensesTable.Rows.Count > 0)
            {
                AddOrUpdateWithdrawalTableToCollection(AgentExpensesTable, AgentExpensesCollection, AgentExpenseCode, AgentExpenses);
                if (isValidRecord)
                {
                    AddOrUpdateWithdrawalCollection(AgentExpensesCollection);
                }
            }
            if(DueToPartnersTable.Rows.Count > 0)
            {
                AddOrUpdateWithdrawalTableToCollection(DueToPartnersTable, DueToPartnersCollection, DueToPartnerCode, DueToPartners);
                if (isValidRecord)
                {
                    AddOrUpdateWithdrawalCollection(DueToPartnersCollection);
                }
            }
            if (BankPositionsTable.Rows.Count > 0)
            {
                AddOrUpdateBankPositionCollection();
                if (isValidRecord)
                {
                    AddOrUpdateWithdrawalCollection(BankPositionsCollection);
                }
            }
            if(PersonalcommissionsTable.Rows.Count > 0)
            {
                AddOrUpdatePersonalCommissionCollection();
                if (isValidRecord)
                {
                    AddOrUpdateWithdrawalCollection(PersonalCommissionsCollection);
                }
            }
            if (isValidRecord)
            {
                _unitOfWork.Commit();
                LoadData();
                _notifier.ShowSuccess("Records updated successfully");
            }
            else
            {
                _notifier.ShowError("Enter valid description and amount");
                return;
            }
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
        private SearchQuery BuildSearchQuery(string dType = DueToPartnerCode)
        {
            int month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month;
            SearchQuery searchQuery = new SearchQuery();
            List<FilterBy> filterBy = new List<FilterBy>();
            filterBy.Add(FilterByEqual("yrmo", SelectedYear.ToString() + month.ToString("D2")));
            filterBy.Add(FilterByIn("dtype", dType));
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

        private FilterBy FilterByIn(string propertyName, string value)
        {
            FilterBy filterBy = new FilterBy();
            filterBy.Property = propertyName;
            filterBy.In = value;
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
        private ViewWithdrawalDto GetNewWithdrawal(DataRow row, string positionCode)
        {
            int month = DateTime.ParseExact(SelectedMonth, "MMM", null).Month;
            ViewWithdrawalDto withdrawal = new ViewWithdrawalDto();
            int withdrawalId = (int)row[WithdrawalIdColumnName];
            withdrawal.WithdrawalId = withdrawalId;
            withdrawal.Yrmo = SelectedYear.ToString() + month.ToString("D2").Trim();
            if (positionCode == BankPositionCode
                || positionCode == AgentExpenseCode
                || positionCode == DueToPartnerCode)
            {
                withdrawal.Desc = row[DescriptionColumnName].ToString().Trim();
            }
            withdrawal.Dtype = positionCode.Trim();

            return withdrawal;
        }

        private bool IsValidRecord(DataRow rowInput, string financeType)
        {
            bool isValid = true;
            switch(financeType)
            {
                case AgentExpenses:
                case DueToPartners:
                    if (string.IsNullOrEmpty(rowInput[DescriptionColumnName].ToString().Trim())
                        && Convert.ToDouble(rowInput[MartyColumnName]) == 0
                        && Convert.ToDouble(rowInput[PeterColumnName]) == 0
                        && Convert.ToDouble(rowInput[FrankColumnName]) == 0
                        && Convert.ToDouble(rowInput[BobColumnName]) == 0
                        && Convert.ToDouble(rowInput[OtherColumnName]) == 0)
                    {
                        isValid = false;
                        isValidRecord = false;
                    }
                    break;

                case BankPositions:
                    if(string.IsNullOrEmpty(rowInput[DescriptionColumnName].ToString().Trim())
                        &&string.IsNullOrEmpty(rowInput[TypeColumnName].ToString())
                        && Convert.ToDouble(rowInput[CmgColumnName]) == 0
                        && Convert.ToDouble(rowInput[ScColumnName]) == 0)
                    {
                        isValid = false;
                        isValidRecord = false;
                    }
                    break;

                case PersonalCommissions:
                    if (Convert.ToDouble(rowInput[MartyColumnName]) == 0
                        && Convert.ToDouble(rowInput[PeterColumnName]) == 0
                        && Convert.ToDouble(rowInput[FrankColumnName]) == 0
                        && Convert.ToDouble(rowInput[BobColumnName]) == 0)
                    {
                        isValid = false;
                        isValidRecord = false;
                    }
                    break;
            }
            return isValid;
        }

        private void AddOrUpdateWithdrawalTableToCollection (DataTable tableInput, ObservableCollection<ViewWithdrawalDto> collection, string positionCode, string financeType)
        {
            foreach (DataRow row in tableInput.Rows)
            {
                if (IsValidRecord(row, financeType))
                { 
                    int withdrawalId = (int)row[WithdrawalIdColumnName];
                    ViewWithdrawalDto withdrawal = GetNewWithdrawal(row, positionCode);
                    List<ViewAgentWithdrawalDto> agentWithdrawals = new List<ViewAgentWithdrawalDto>();
                    ViewAgentWithdrawalDto agentWithdrawal = new ViewAgentWithdrawalDto();

                    if (withdrawalId > 0)
                    {
                        withdrawal = collection.Where(x => x.WithdrawalId == withdrawalId).FirstOrDefault();
                        withdrawal.Desc = row[DescriptionColumnName].ToString().Trim();
                        agentWithdrawals = withdrawal.AgentWithdrawals.ToList();
                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[MartyColumnName]);
                        }
                        else if (Convert.ToDouble(row[MartyColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[MartyColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[PeterColumnName]);
                        }
                        else if (Convert.ToDouble(row[PeterColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[PeterColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[FrankColumnName]);
                        }
                        else if (Convert.ToDouble(row[FrankColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[FrankColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[BobColumnName]);
                        }
                        else if (Convert.ToDouble(row[BobColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Bob, withdrawalId, Convert.ToDouble(row[BobColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Others).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Others).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[OtherColumnName]);
                        }
                        else if (Convert.ToDouble(row[OtherColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Others, withdrawalId, Convert.ToDouble(row[OtherColumnName])));
                        }
                    }
                    else if (withdrawalId < 0)
                    {
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[MartyColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[PeterColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[FrankColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Bob, withdrawalId, Convert.ToDouble(row[BobColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Others, withdrawalId, Convert.ToDouble(row[OtherColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }

                        withdrawal.AgentWithdrawals = agentWithdrawals;
                        if (collection.Where(x => x.WithdrawalId == withdrawalId).Count() == 0)
                        {
                            collection.Add(withdrawal);
                        }
                    }
                }
                else
                {
                    break;
                }
            }
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
        private void AddOrUpdatePersonalCommissionCollection()
        {
            string withdrawalType = string.Empty;
            foreach (DataRow row in PersonalcommissionsTable.Rows)
            {
                if(IsValidRecord(row, PersonalCommissions))
                { 
                    int withdrawalId = (int)row[WithdrawalIdColumnName];
                    if (row[IsPcEnteredColumnName].ToString() == string.Empty)
                        row[IsPcEnteredColumnName] = false;
                    withdrawalType = Convert.ToBoolean(row[IsPcEnteredColumnName]) ? PersonalCommissionEnteredCode : PersonalCommissionNotEnteredCode;
                    ViewWithdrawalDto withdrawal = GetNewWithdrawal(row, withdrawalType);
                    List<ViewAgentWithdrawalDto> agentWithdrawals = new List<ViewAgentWithdrawalDto>();
                    ViewAgentWithdrawalDto agentWithdrawal = new ViewAgentWithdrawalDto();

                    if(withdrawalId > 0)
                    {
                        withdrawal = PersonalCommissionsCollection.Where(x => x.WithdrawalId == withdrawalId).FirstOrDefault();
                        withdrawal.Dtype = withdrawalType;
                        agentWithdrawals = withdrawal.AgentWithdrawals.ToList();

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[MartyColumnName]);
                        }
                        else if (Convert.ToDouble(row[MartyColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[MartyColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[PeterColumnName]);
                        }
                        else if (Convert.ToDouble(row[PeterColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[PeterColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[FrankColumnName]);
                        }
                        else if (Convert.ToDouble(row[FrankColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[FrankColumnName])));
                        }

                        if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault() != null)
                        {
                            agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Bob).FirstOrDefault();
                            agentWithdrawal.Amount = Convert.ToDouble(row[BobColumnName]);
                        }
                        else if (Convert.ToDouble(row[BobColumnName]) > 0)
                        {
                            withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Bob, withdrawalId, Convert.ToDouble(row[BobColumnName])));
                        }
                    }
                    else if(withdrawalId < 0)
                    {
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[MartyColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[PeterColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[FrankColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Bob, withdrawalId, Convert.ToDouble(row[BobColumnName]));
                        if (agentWithdrawal != null)
                        {
                            agentWithdrawals.Add(agentWithdrawal);
                        }
                        withdrawal.AgentWithdrawals = agentWithdrawals;
                        if (PersonalCommissionsCollection.Where(x => x.WithdrawalId == withdrawalId).Count() == 0)
                        {
                            PersonalCommissionsCollection.Add(withdrawal);
                        }
                    }
                }
                else
                {
                    break;
                }
            }
        }
        private void AddOrUpdateBankPositionCollection()
        {
            if (BankPositionsTable.Rows.Count > 0)
            {
                foreach (DataRow row in BankPositionsTable.Rows)
                {
                    if(IsValidRecord(row, BankPositions))
                    { 
                        int withdrawalId = (int)row[WithdrawalIdColumnName];
                        ViewWithdrawalDto withdrawal = GetNewWithdrawal(row, BankPositionCode);
                        List<ViewAgentWithdrawalDto> agentWithdrawals = new List<ViewAgentWithdrawalDto>();
                        ViewAgentWithdrawalDto agentWithdrawal = new ViewAgentWithdrawalDto();
                        withdrawal.Ctype = row[TypeColumnName].ToString().Trim();
                        if (withdrawalId > 0)
                        {
                            withdrawal = BankPositionsCollection.Where(x => x.WithdrawalId == withdrawalId).FirstOrDefault();
                            withdrawal.Desc = row[DescriptionColumnName].ToString().Trim();
                            withdrawal.Ctype = row[TypeColumnName].ToString().Trim();
                            agentWithdrawals = withdrawal.AgentWithdrawals.ToList();
                            if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault() != null)
                            {
                                agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Marty).FirstOrDefault();
                                agentWithdrawal.Amount = Convert.ToDouble(row[CmgColumnName]);
                            }
                            else if (Convert.ToDouble(row[CmgColumnName]) > 0)
                            {
                                withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[CmgColumnName])));
                            }

                            if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault() != null)
                            {
                                agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Peter).FirstOrDefault();
                                agentWithdrawal.Amount = Convert.ToDouble(row[ScColumnName]);
                            }
                            else if (Convert.ToDouble(row[ScColumnName]) > 0)
                            {
                                withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[ScColumnName])));
                            }

                            if (agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault() != null)
                            {
                                agentWithdrawal = agentWithdrawals.Where(x => x.AgentId == (int)AgentEnum.Frank).FirstOrDefault();
                                agentWithdrawal.Amount = Convert.ToDouble(row[TdColumnName]);
                            }
                            else if (Convert.ToDouble(row[TdColumnName]) > 0)
                            {
                                withdrawal.AgentWithdrawals.Add(AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[TdColumnName])));
                            }
                        }
                        else if (withdrawalId < 0)
                        {
                            agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Marty, withdrawalId, Convert.ToDouble(row[CmgColumnName]));
                            if (agentWithdrawal != null)
                            {
                                agentWithdrawals.Add(agentWithdrawal);
                            }
                            agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Peter, withdrawalId, Convert.ToDouble(row[ScColumnName]));
                            if (agentWithdrawal != null)
                            {
                                agentWithdrawals.Add(agentWithdrawal);
                            }
                            agentWithdrawal = AddViewAgentWithdrawalDto((int)AgentEnum.Frank, withdrawalId, Convert.ToDouble(row[TdColumnName]));
                            if (agentWithdrawal != null)
                            {
                                agentWithdrawals.Add(agentWithdrawal);
                            }

                            withdrawal.AgentWithdrawals = agentWithdrawals;
                            if (BankPositionsCollection.Where(x => x.WithdrawalId == withdrawalId).Count() == 0)
                            {
                                BankPositionsCollection.Add(withdrawal);
                            }
                        }
                    }
                    else
                    {                        
                        break;
                    }
                }
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
