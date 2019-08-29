//using CMG.Application.Command;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using CMG.DataAccess.Respository;
using CMG.DataAccess.Interface;
using MediatR;
using CMG.Application.ViewModel;
using AutoMapper;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly ICommissionRepository _commissionRepository;
        public readonly IUnitOfWork _unitOfWork;

        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            CommissionViewModel test = new CommissionViewModel(_unitOfWork, _mapper);

            InitializeComponent();
        }
    }
}
