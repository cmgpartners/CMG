using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Query;
using System.Collections.ObjectModel;
using System.Linq;
using System.Windows.Input;

namespace CMG.Application.ViewModel
{
    public class SearchViewModel : BaseViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion Member variables

        #region Properties
        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set { _dataCollection = value; }
        }
        public ICommand SearchCommand
        {
            get { return CreateCommand(Search); }
        }
        #endregion Properties

        #region Constructor
        public SearchViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        #endregion Constructor

        #region Methods
        public void Search()
        {
            SearchQuery searchQuery = new SearchQuery();
            var dataSearchBy = _unitOfWork.Commissions.Find(searchQuery);
           // DataCollection = new ObservableCollection<ViewCommissionDto>(dataSearchBy.Result.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
        }
        #endregion Methods
    }
}
