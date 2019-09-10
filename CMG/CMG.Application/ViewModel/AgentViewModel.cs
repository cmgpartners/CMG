using AutoMapper;
using CMG.Application.DTO;
using CMG.DataAccess.Domain;
using CMG.DataAccess.Interface;
using CMG.DataAccess.Respository;
using System.Collections.ObjectModel;

namespace CMG.Application.ViewModel
{
    public class AgentViewModel
    {
        #region Member variables
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        #endregion Member variables

        #region Properties
        private ObservableCollection<ViewAgentDto> _dataCollection;
        public ObservableCollection<ViewAgentDto> DataCollection
        {
            get { return _dataCollection; }
            set { _dataCollection = value; }
        }
        #endregion Properties

        #region Constructor
        public AgentViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
        }
        #endregion Constructor
        
        #region Methods
        public void Add(ViewAgentDto srouce)
        {
            var agent = _mapper.Map<Agent>(srouce);
            _unitOfWork.Agents.Add(agent);
            _unitOfWork.Commit();
        }

        public void Delete(int id)
        {
            var agent = _unitOfWork.Agents.Find(id);
            _unitOfWork.Agents.Delete(agent);
            _unitOfWork.Commit();
        }

        public void Edit(ViewAgentDto source)
        {
            var agent = _unitOfWork.Agents.Find(source.Id.Value);
            _mapper.Map(source, agent);

            _unitOfWork.Agents.Save(agent);
            _unitOfWork.Commit();
        }
        #endregion Methods
    }
}
