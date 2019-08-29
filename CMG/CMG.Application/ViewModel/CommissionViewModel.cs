using CMG.Application.DTO;
using CMG.DataAccess.Interface;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using CMG.Common;
using AutoMapper;

namespace CMG.Application.ViewModel
{
    public class CommissionViewModel : Profile
    {
        public int Keycomm { get; set; }
        public string Commtype { get; set; }
        public string Yrmo { get; set; }

        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;

        public CommissionViewModel(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            GetAllComm();
        }

        private ObservableCollection<ViewCommissionDto> _dataCollection;
        public ObservableCollection<ViewCommissionDto> DataCollection
        {
            get { return _dataCollection; }
            set { _dataCollection = value; }
        }

        public async void GetAllComm()
        {
            var dataCommissiosns = await _unitOfWork.Commissions.All();
            _dataCollection = new ObservableCollection<ViewCommissionDto>(dataCommissiosns.Select(r => _mapper.Map<ViewCommissionDto>(r)).ToList());
        }
    }
}
