using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Windows.Input;
using static CMG.Common.Enums;
using System.Linq;

namespace CMG.Application.ViewModel
{
    public class MainViewModel : BaseViewModel
    {
        #region MemberVariables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion MemberVariables

        #region Constructor
        public MainViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
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
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
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
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
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
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
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
                SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
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
        #endregion Methods
    }
}
